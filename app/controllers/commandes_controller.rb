# -*- encoding : utf-8 -*-
class CommandesController < ApplicationController
  
  before_action :check_register_workflow
  helper_method :sort_column, :sort_direction
  autocomplete :personne, :nom, :full => true, :display_value => :nom_complet, extra_data: [:id, :prenom ] 

  require "prawn"
  require 'csv'
  

  def new
    if Configurable[:commandes_possibles] == true || @current_user.admin?

      @commande = Commande.new(:personne_id => params[:pers_id])
      authorize! :create, @commande
      @personne=Personne.find_by_id(params[:pers_id]) if params[:pers_id]
      @packs=Pack.all
      @events=Event.all.to_a
      @personne.commandes.each{|c| @events.delete c.event} if @personne
      logger.debug @events.to_s
      @commande.tbk = @personne.default_tbk if @personne
      redirect_to(personne_url(@personne), notice: "Vous êtes déjà inscrit à tout les évènements") if @events.blank?
    else
      redirect_to dashboard_user_path(current_user), alert: "Les commandes sont désormais fermées"
    end
  end

  def create
    # pour la generation du code ean13 qui sert aussi d'id publique:
    # (SecureRandom.random_number *10**14).to_s[0,13]

    @commande = Commande.new(commande_params)
    authorize! :create, @commande

    @commande.idlong=@commande.gen_idlong

    respond_to do |format|
      if @commande.save
        format.html { redirect_to catalogue_commande_path(@commande.id), notice: 'Votre commande a bien été créée' }
        format.json { head :no_content }
      else
        format.html { render 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    set_commande
    authorize! :update, @commande
    @events=Event.all.to_a
    @packs=Pack.all
  end

  def update
    set_commande
    authorize! :create, @commande

    respond_to do |format|
      if @commande.update(commande_params)
        format.html { redirect_to dashboard_user_url @commande.personne.user, notice: 'Votre commande a bien été créée' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @commande.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
  	@commandes = Commande.order(sort_column + " " + sort_direction).paginate(:page => params[:page])
	@paiements = Paiement.where(verif: true, en_attente: false)
  	authorize! :show, @commandes

    respond_to do |format|
      format.html
      format.xls
    end

  end

   def index_ean
    @commandes = Commande.all.order(event_id: :asc)
   end

  def export
    pool_size=Configurable[:export__commande_pool_size]
    page_number=params[:page].to_i || 1
    debut=(page_number-1)*pool_size
    fin=(page_number)*pool_size-1
    coms = Commande.order("updated_at").select{|c| c.montant_paye > 0}[debut..fin]
    @commandes = coms.map{|c| c.serialize}
    authorize! :show, @commandes

    nbr_pages=(Paiement.where(verif: true, etape: '1').count/pool_size.to_f).ceil

    respond_to do |format|
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' +"export_commandes_"+Date.today.to_s+"_"+page_number.to_s+"of"+nbr_pages.to_s+ '.xls"'
      end
    end
  end
  
  def export_last_payment
    pool_size=Configurable[:export__commande_pool_size]
    page_number=params[:page].to_i || 1
    debut=(page_number-1)*pool_size
    fin=(page_number)*pool_size-1
    coms_trd = Commande.order("updated_at").select{|c| c.montant_paye < c.montant_total}[debut..fin]
    @commandes_trd = coms_trd.map{|c| c.serialize}
    authorize! :show, @commandes

    nbr_pages_trd=(Commande.order("updated_at").select{|c| c.montant_paye < c.montant_total}.count/pool_size.to_f).ceil

    respond_to do |format|
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' +"export_commandes_"+Date.today.to_s+"_"+page_number.to_s+"of"+nbr_pages.to_s+ '.xls"'
      end
    end
  end

  def show
  	@commande = Commande.includes(:personne, :event, :paiements, :products).find(params[:id])
  	authorize! :show, @commande

    @personne = @commande.personne

   	##### à definir quand les associations commande <-> produits seront faites
  	# liste des produit d'une commande
    @produits = @commande.products

   	# total du prix d'une commande
   	# total = @produits.map{|p| p.price}.sum
   	@total_euro = @commande.montant_total.to_i / 100.0

   	# liste des paiements associés à une commande
   	@paiements = @commande.paiements
   	# total des paiements d'une commande pour préparer à la vérification
   	@totalpaiement_euro = @commande.montant_paye / 100.0

   	@paiement_du_euro = @commande.montant_du.to_i / 100.0
   	##### Vérification du statut d'une commande
   	# status = true si:
   	# @total = @totalpaiement ET
   	# (la personne à une assurance ET a donné un justificatif) OU a dans sa commande un produit assurance 
   	
   	# if total_cents == totalpaiement_cents
   	# 	@paiementok = true 
   	# else
   	# 	@paiementok = false
   	# end

   	# assurance_personne = @personne.assurance
   	# assurance_document_personne = @personne.documentassurance
   	# assurance_dans_produit = false #vlaur arbitraire pour test. à coder

   	# if ((@personne.assurance and @personne.documentassurance) or assurance_dans_produit)
   	# 	@assuranceok = true
   	# else
   	# 	@assuranceok = false
   	# end

   	# if @assuranceok && @paiementok
   	# 	@status=true
   	# else
   	# 	@status=false
   	# end

   	@status = @commande.complete?

    respond_to do |format|
      format.html
      format.pdf do
        pdf = CommandePdf.new(@commande, @personne,@total_euro, @paiements)
        send_data pdf.render, filename: "facture #{@personne.nom_complet}.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
   end

require 'barby'
 require 'barby/barcode/ean_13'
 require 'barby/outputter/svg_outputter'
   def show_recap

    @commande = Commande.find(params[:commande_id])
    authorize! :show, @commande
    @personne = @commande.personne
    @produits = @commande.products
    @total_euro = @commande.montant_total.to_i / 100.0
    @paiements = @commande.paiements
    @totalpaiement_euro = @commande.montant_paye / 100.0
    @paiement_du_euro = @commande.montant_du.to_i / 100.0
    @barcode = Barby::EAN13.new(@commande.ean.to_s[0...12])
    @outputter = Barby::SvgOutputter.new(@barcode)
    @outputter.xdim = 2

    # render :layout => "print"
   end


   def index_remboursement
    commandes=Commande.all
    @commandes_remb=commandes.map{|c| c if c.montant_du < 0 }.compact
   end

   def add_product
    set_commande

    authorize! :add_product, @commande

    @product = Product.find_by_id(params[:product_id])

    if @product
      respond_to do |format|
        if @commande.add_product @product
          format.html { redirect_to @commande }
          format.json { render json: '' }
        else
          format.json { render json: "Error : Can't add", status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: "Error", status: :unprocessable_entity }
      end
    end
  end

  def remove_product
    set_commande

    authorize! :add_product, @commande

    @product = Product.find_by_id(params[:product_id])

    if @product
      respond_to do |format|
        if @commande.remove_product @product
          format.html { redirect_to @commande }
          format.json { render json: '' }
        else
          format.json { render json: "Error : Can't add", status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: "Error", status: :unprocessable_entity }
      end
    end
  end

  def catalogue
    if Configurable[:commandes_editables] == true || @current_user.admin?
      set_commande
      authorize! :add_product, @commande    

      @categories=Categorie.order(:id).all.map do|c|

        prods = c.products.where(event_id: @commande.event_id)

        select = @commande.commande_products.select{|cp| cp.product.categorie_id==c.id}.first
        select_id = select ? select.product_id : 0

        {id: c.id,nom: c.nom, max: c.max_par_personne, selected: select_id ,products: prods }

      end
    else
      redirect_to :back, alert: "Les commandes sont désormais bloquées!"
    end

  end

  def maj_cat_product
    set_commande

    authorize! :add_product, @commande

    @product = Product.find_by_id(params[:product_id]||0)
    @cat = Categorie.find(params[:categorie_id])

    ok = true
    ok = false unless (@cat.products.include?(@product)|| not(@product))

    if ok

      @cat.products.each do |p|
        @commande.commande_products.where(product_id: p.id).delete_all
      end


      respond_to do |format|
        if not(@product) || @commande.add_product(@product)
          format.html { redirect_to @commande }
          format.json { render json: '' }
        else
          format.json { render json: "Error : Can't add", status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: "Error", status: :unprocessable_entity }
      end
    end
  end

  def maj_product_personne_preference
    set_commande
    authorize! :add_product, @commande

    @product = Product.find_by_id(params[:product_id])
    @preference = @product.product_personne_preferences.build(product_personne_preferences_params)	

    @preference.commande = @commande
    @preference.personne = @commande.personne

    if @product.product_personne_preferences.where(commande_id: @commande.id).present?
      @preference = @product.product_personne_preferences.where(commande_id: @commande.id).first
      @preference.preference = product_personne_preferences_params[:preference]
      
      respond_to do |format|
        if @preference.save
          format.js
        end
      end
    else
      @preference.preference = product_personne_preferences_params[:preference]
      if @preference.save
        redirect_to catalogue_commande_path(@commande)
      end
    end
  end
  
  def add_caution
    @lastcautioncommandes = Commande.where.not(caution_updated_at: '').where(caution: true).order(caution_updated_at: :desc).limit(10)

    authorize! :show, @commandes

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def check_in

    @commande = Commande.find_by_ean params[:ean]

    if @commande && @commande.check_in
      redirect_to admin_check_in_path
    else
      redirect_to admin_check_in_path, alert: "Can't Check In"
    end
  end

  def get_infos

    @commande = Commande.find_by_ean params[:ean]


    if @commande

      infos = Hash.new

      infos[:nom_complet]=@commande.personne.nom_complet
      chambre=@commande.personne.chambres.where(event_id: @commande.event_id).first
      infos[:chambre]=chambre.identifiant
      infos[:chambree]=chambre.personnes.map{|p| {
        nom: p.nom_complet,
        etat_paiement: p.commandes.find_by_event_id(chambre.event_id).paiementok? ? "ok" : "NON",
        etat_assurance: p.commandes.find_by_event_id(chambre.event_id).personne.documentassurance? ? "ok" : "NON",
        etat_caution: p.commandes.find_by_event_id(chambre.event_id).caution ? "ok" : "NON"
        }
      }

      render json: infos.to_json
    else
      render json: "", status: :unprocessable_entity
    end

  end

  def validate_caution
    authorize! :read_admin, User
    personne=Personne.find(params[:id])
    personne.commandes.map { |c| c.a_donne_caution }
    redirect_to :back
  end

  def validate_caution_batch
    authorize! :read_admin, User
    nbre_cautions_validee = 0
    file=params[:file]
    if File.extname(file.original_filename) == '.csv'
      CSV.foreach(file.path,headers: true) do |row|
        Commande.find(row['commande_id'].to_i).a_donne_caution
        nbre_cautions_validee +=1
      end
      
      respond_to do |format|
        format.html { redirect_to :back, :notice => nbre_cautions_validee.to_s + " cautions validées avec succés!"}
      end
    else
      flash[:error] = "Erreur de validation"
      redirect_to :back
    end
  end


  private

    def set_commande
      @commande = Commande.find(params[:id])
    end

    def commande_params
      params.require(:commande).permit(:personne_id,:event_id,:tbk_id,:glisse_id,:caution,:products_attributes => [])
    end

    def product_personne_preferences_params
      params.require(:product_personne_preference).permit(:id, :product_id, :personne_id, :preference)
    end
	
    def sort_column
      Commande.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
