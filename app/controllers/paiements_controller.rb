class PaiementsController < ApplicationController

  before_action :check_register_workflow  
  load_and_authorize_resource

  require 'csv'

  def create

  end

  def new

   com=Commande.find(params[:commande_id])
   if com.montant_du != 0

    p=com.paiements.create(
      :idlong => (SecureRandom.random_number *10**14).to_s[0,13],
      :amount_cents => com.prochain_paiement,
      :paiement_hash => "paiement en cours...",
      :verif => false)

    p.paiement_hash=hashpaiement(p)
    p.save if p.valid?

    respond_to do |format|
        #décommenter la ligne ci-dessous pour payer par gadz.org
        format.html{redirect_to urlpaiement(p).to_s}
        format.html{redirect_to commande_path(com.id), notice: "Votre paiement a bien été pris en compte." }
      end
    else
      redirect_to commande_path(com.id), alert: "Votre commande est déjà payée en totalité." 
    end
  end

  def index
    authorize! :read_admin, User
    @paiements=Paiement.all
  end

  def show
   authorize! :show, @commandes
   @paiement=Paiement.find(params[:id])
   @commande=@paiement.commande
   @personne=@commande.personne
   @referant=@personne.referant
   @url=urlpaiement(@paiement)
 end

 def update
 end

 def check
  @paiements_verified = Paiement.find(:all, :order => "verified_at", :conditions => {:verif => true }).paginate(:page => params[:page])
  @paiements = Paiement.all.where(verif: false).sort_by{|a| a.created_at.to_s}
  
 end

 def csv_import    
  file_data = params[:file].read
  csv_rows  = CSV.parse(file_data,encoding: "UTF-8", :row_sep => "\r\r\n",:col_sep => ';')

  nbre_paiements_valides = 0
  nbre_paiement=csv_rows.size - 2
  csv_rows.each_with_index do |row,line|
    case line
    when 1
      # useless
    when 2
      # header2
    else
      nbre_paiements_valides +=1 if validate_paiement(row[21],row[4])
    end
    
  end

  respond_to do |format|
    format.html { redirect_to check_paiement_path, :notice => "CSV traité avec succés! " + nbre_paiements_valides.to_s + " paiements validés sur " + nbre_paiement.to_s  + " présents dans le fichier.", :plop => "truc" }
  end
 end



private
  def site
    return "PayResaSKZ"
  end
  def ref
    return 126
  end

  def hashpaiement(paiement)
    secret = Configurable[:secret_paiement]
    return Digest::SHA1.hexdigest( paiement.amount_euro.to_s + '+' + paiement.commande.personne.email + '+' + ref.to_s + '+' + site + '+' + secret)
  end
  ###################################################################
  # Copyright (c) 2012 Thomas Fuzeau
  # Under MIT licence.
  # More info: http://opensource.org/licenses/mit-license.php
  ###################################################################
  def urlpaiement(paiement)
    # order = transaction.order
    r=paiement.commande.personne.user.referant
    require 'addressable/uri'
    require 'addressable/template'

    
    
    template = Addressable::Template.new("https://www.gadz.org/external/payment/{ref}/montant/{amount}")

    params = {
      :firstname => r.nom,
      :lastname => r.prenom,
      :email => r.email,
      :sex => r.genre.nom_cas,
      :phone => r.phone,
      :address => [r.adresse," " ,r.complement, " ",r.codepostal, " ",r.ville].join, #[current_user.address_1, current_user.address_2, current_user.postcode, current_user.city].join(" "),
      :op => "submit",
      :order_id => paiement.id,
      :site => site,
      :version => "1",
      :hash => hashpaiement(paiement),
      :cgu => 1
    }
    uri = template.expand({"ref" => ref.to_s, "amount" => paiement.amount_euro.to_s })
    uri.query_values = params
    uri
  end

  def validate_paiement(paiement_id_long, csv_amount_cents)
    paiement=Paiement.find_by(idlong: paiement_id_long)
    if !paiement.nil? && !paiement.verif? && paiement.amount_cents.to_i ==  csv_amount_cents.to_i
      paiement.set_verif
      # logger.info "###########################Validation"
      return true  
    else 
      return false   
    end
  end

end
