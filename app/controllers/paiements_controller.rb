# -*- encoding : utf-8 -*-
class PaiementsController < ApplicationController

  before_action :check_register_workflow  
  helper_method :sort_column, :sort_direction


  

  def create
    # attention les controleur create et new on été fait à l'arrache.
    # C'es sale mais ça marche. Mais ce serait mieux de modifier ça quand même.
    com=Commande.find(params[:commande_id])
    p=com.paiements.new(
      :amount_cents => com.prochain_paiement,
      :paiement_hash => "paiement en cours...",
      :verif => false)


    p.idlong=p.gen_idlong
    p.paiement_hash=hashpaiement(p)
    p.save if p.valid?
    respond_to do |format|
        #décommenter la ligne ci-dessous pour payer par gadz.org
        format.html{redirect_to urlpaiement(p).to_s}
        format.html{redirect_to commande_path(com.id), notice: "Votre paiement a bien été pris en compte." }
      end
  end

  def new
      com=Commande.find(params[:commande_id])
      @paiement = com.paiements.new
      authorize! :create, @paiement
    # on vérifie si le nombre de commande maxi est atteint ET qu'on est au premier paiement
    # la méthode utilisée ici n'utilise pas les fonction pour vérifier le montant total car ce serait trop long
    
    #nombre_commande_avec_paiement = Paiement.where(verif: true).map{|p| p.commande}.uniq.count
    #if nombre_commande_avec_paiement <= Configurable[:max_commamdes_payables] || com.paiement_etape >= 0 

      @montant=com.prochain_paiement / 100.0
      @etape=(com.paiement_etape + 1).to_s

      com=Commande.find(params[:commande_id])
      if com.montant_du > 0

      else
        redirect_to commande_path(com.id), alert: "Votre commande est déjà payée en totalité." 
      end

      if @montant == 0
       redirect_to commande_path(com.id), alert: "Vous ne pouvez effectuer un paiement de 0€." 
     end
   #else
    #redirect_to commande_path(com.id), alert: "Nombre maximun d'inscrit atteint."
   #end

 end

 def index
    authorize! :read_admin, User
    @paiements=Paiement.all.order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 50)
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
  authorize! :read_admin, User
end

require 'will_paginate/array'
def check
  authorize! :read_admin, User
  @paiements_verified = Paiement.find(:all, :order => "verified_at", :conditions => {:verif => true }).paginate(:page => params[:page],:per_page => 50)
  authorize! :show, @personnes
  @paiements = Paiement.all.where(verif: false).sort_by{|a| a.created_at.to_s}

end

def force_validation
  authorize! :read_admin, User
  paiement=Paiement.find(params[:paiementid])
  paiement.force_valid(@current_user.id)
  redirect_to :back, notice: "La validation à forcée"


end

require 'csv'

def csv_import
  authorize! :read_admin, User  

  amount_cents_row = 4
  id_long_row = 21
  reponse_code_row = 12
  banque_reponse_code_row = 29

  file_data = params[:file].read

    #handle the differents csv row sep
    if file_data.include?("\r\r\n")
     csv_rows  = CSV.parse(file_data,encoding: "UTF-8",:row_sep=> "\r\r\n", :col_sep => ';')
   else
    csv_rows  = CSV.parse(file_data,encoding: "UTF-8",:col_sep => ';')
  end
  nbre_paiements_valides = 0
  nbre_paiements_refuses = 0
  nbre_paiement=csv_rows.size - 2
  csv_rows.each_with_index do |row,line|
    case line
    when 0
        # useless
      when 1 
        # header2
      else
        valcode=validate_paiement(row[id_long_row],row[amount_cents_row],row[reponse_code_row],row[banque_reponse_code_row])
        nbre_paiements_valides +=1 if valcode[0]
        nbre_paiements_refuses +=1 if valcode[1]
      end

    end

    respond_to do |format|
      format.html { redirect_to check_paiement_path, :notice => "CSV traité avec succés! " + nbre_paiements_valides.to_s + " paiements traités sur " + nbre_paiement.to_s  + " présents dans le fichier. " + nbre_paiements_refuses.to_s + " paiement ont été refusés pas la banque." , :plop => "truc" }
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
    return Digest::SHA1.hexdigest( paiement.amount_euro.to_s + '+' + paiement.commande.personne.user.referant.email + '+' + ref.to_s + '+' + site + '+' + secret)
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
      :order_id => paiement.idlong,
      :site => site,
      :version => "1",
      :hash => hashpaiement(paiement),
      :cgu => 1
    }
    uri = template.expand({"ref" => ref.to_s, "amount" => paiement.amount_euro.to_s })
    uri.query_values = params
    uri
  end

  def validate_paiement(paiement_id_long, csv_amount_cents, reponse_code, banque_reponse_code)
  # retrourne un array de booleen.
  # [true si un paiement du site est validé, true si paiement refusé par la banque]


    if paiement_id_long.to_s.size < 4 && !paiement_id_long.nil?
        # ceci est necessaire poour valider les premiers paiement suite à l'erreur dans le hash généré avec id et non idlong
        paiement=Paiement.find_by(id: paiement_id_long.to_i)
      else
        paiement=Paiement.find_by(idlong: paiement_id_long)
    end
      if !paiement.nil? && !paiement.verif? && paiement.amount_cents.to_i ==  csv_amount_cents.to_i
        if reponse_code == "00" && banque_reponse_code == "00"
          paiement.set_verif
          return [true,false]
        else
          paiement.set_erreur(reponse_code)
          return [false,true]
        end
        # logger.info "###########################Validation"

      else 
        return [false,false]   
      end
  end

  def paiement_params
    params.require(:paiement).permit(:idlong,:amount_cents,:paiement_hash,:verif)
  end

  def sort_column
      Paiement.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
