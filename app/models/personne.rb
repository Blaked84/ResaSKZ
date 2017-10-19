#encoding: utf-8
class Personne < ActiveRecord::Base

	#################################################
	# Les personnes physiques. Appartiennent à un user
	# Les champs précédés de "p" correspondent à la 
	# personne à contacter en cas de problème
	#################################################
	has_many :groupe
	belongs_to :genre
	has_one :usertype
	belongs_to :user
        # Mensurations
	belongs_to :taillevetement
	belongs_to :tour_tete
        belongs_to :niveau_ski

	has_many :commandes, dependent: :destroy, inverse_of: :personne
        accepts_nested_attributes_for :commandes, :reject_if => :reject_nested, :allow_destroy => true

        has_many :product_personne_preferences
	#has_and_belongs_to_many :chambres
	has_many :activites, through: :activites_personnes
	has_many :activites_personnes, dependent: :destroy
	belongs_to :typeresid
	belongs_to :lit
	#has_many :lits, through: :lits_personnes
	has_and_belongs_to_many :lits
	#attr_accessible :nom, :prenom, :phone, :email, :assurance
	has_many :chambres, :through => :lit  

	@@types= %w(Pec's Gadz)

#### VALIDATIONS ##############################################################

###### Attributs ##############################################################

	# validates :email, presence: true
	validates :email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
	# validates :nom, presence: true
	validates :nom , :length => { :in => 2..30 }
	# validates :prenom, presence: true
	validates :prenom , :length => { :in => 2..30 }
	validates :phone, :format => { :with => /\A((0|\+[1-9]{2})[1-9][0-9]{8})?\Z/ }, presence: true
	# validates :assurance ,:inclusion => {  :in => [true,false]}
	validates :adresse , :presence => true
	validates :ville , :presence => true
	validates :codepostal , :presence => true
	validates :taille , :presence => true
	validates :taille , :numericality => true
	validates :pointure , :presence => true
	validates :pointure , :numericality => true

	# validates :pnom, presence: true
	validates :pnom , :length => { :in => 2..30 }
	# validates :pprenom, presence: true
	validates :pprenom , :length => { :in => 2..30 }
	validates :plienparente, presence: true
	validates :pphone, :format => { :with => /\A((0|\+[1-9]{2})[1-9][0-9]{8})?\Z/ }
	validates :padresse , :presence => true
	validates :pville , :presence => true
	validates :pcodepostal , :presence => true
	validates :type_pers, :inclusion => {  :in => @@types}
        validates :typeresid_id, :presence => true

	# validates :documentassurance, :inclusion => {  :in => [true,false]}
	# validates :enregistrement_termine, :inclusion => {  :in => [true,false]}

	#validates :bucque	,:presence => true, if: :is_gadz?
	#validates :fams	    ,:presence => true, if: :is_gadz?
	validates :promo	,:format => { :with => /\A(ai|bo|cl|li|ch|me|an|ka)[0-9]{3}\Z/ }, if: :is_gadz?

###### Associations ###########################################################
	validates :user, presence: true
	validates :genre, presence: true
	validates :taillevetement, presence: true
	validates :tour_tete, presence: true
	validates :niveau_ski, presence: true

###############################################################################
	  # EXTRACT FROM SCHEMA
	  # create_table "personnes", force: true do |t|
	  #   t.string   "email"
	  #   t.string   "nom"
	  #   t.string   "prenom"
	  #   t.string   "phone"
	  #   t.datetime "naissance"
	  #   t.integer  "genre_id"
	  
	  #   t.boolean  "assurance"
	  #   t.datetime "created_at"
	  #   t.datetime "updated_at"
	  #   t.integer  "user_id"
	  
	  #   t.string   "adresse"
	  #   t.string   "ville"
	  #   t.integer  "codepostal"
		  #   t.string   "bucque"
		  #   t.string   "fams"
		  #   t.string   "promo"
		  #   t.string   "idGadzOrg"
	  #   t.integer  "taille"
	  #   t.integer  "pointure"
	  #   t.integer  "taillevetement_id"
	  #   t.string   "complement"
	  
	  #   t.string   "pnom"
	  #   t.string   "pprenom"
	  #   t.string   "plienparente"
	  #   t.string   "padresse"
	  #   t.string   "pcomplement"
	  #   t.string   "pville"
	  #   t.string   "pcodepostal"
	  #   t.string   "pphone"
	  
	  
	  #   t.boolean  "documentassurance"
	  #   t.boolean  "enregistrement_termine"
	  # end

#=== Valeur par défaut  ==============================================
	after_initialize :init

def init
	self.disabled ||= false
end

#=== Méthodes publiques ==============================================
def reject_nested(attributes)
    exists = attributes['id'].present?
    empty = attributes.slice(:when, :where).values.all?(&:blank?)
    attributes.merge!({:_destroy => 1}) if exists and empty
    return (!exists and empty)
end

def disabled?
	if self.disabled
		return true
	end
end

def nom_complet
    return self.prenom.to_s+" "+self.nom.to_s if !self.prenom.nil? && !self.nom.nil?
end

def infos_completes
	return "[#{self.id}] #{self.prenom.to_s} #{self.nom.to_s}"
end

def taille_metre
	if self.taille
		return self.taille / 100.0
	end
end

def referant
	return self.user.referant 
end

def is_referant?
	self == self.user.referant 
end

def referant?
	if self == self.user.referant 
		return "Compte référent"
	else
		return "Lié au compte de: " + self.referant.nom_complet
	end
end

def is_gadz?
	%w(Gadz).include? self.type_pers
end

def is_pg?
  return type_gadz == "PG"
end

def is_jp?
  return type_gadz == "JP"
end

def is_archi?
  return type_gadz == "Archi"
end

def is_pecs?
	%w(Pec's).include? self.type_pers
end


# def assure?
# 	return self.assurance 
# end

def document_assurance
	if self.documentassurance
		return "Document fourni"
	else
		return "Document à fournir ou en cours de traitement"
	end

end

def a_donne_justificatif_assurance
	self.documentassurance=true
	self.assurance_uptated_at=DateTime.now
	self.save
end

def p_nom_complet
    return self.pprenom.to_s+" "+self.pnom.to_s
end

def sync_from_user(user, opt=Hash.new)
  self.prenom = user.first_name
  self.nom=user.last_name
  self.genre=Genre.from_cas(user.gender)
  self.email=user.email
  self.idGadzOrg=user.uid
  if opt[:without_save]
  	true
  else
  	self.save(:validate => false) 
  end

end

def annee_promo

	if self.is_gadz?

		annee=promo.match(/\A(ai|bo|cl|li|ch|me|an|ka)([0-9]{3})\Z/)[2]

		annee.insert(1,"9") if annee[0]=="1"
		annee.insert(1,"0") if annee[0]=="2"

		return annee.to_i
	end

	nil

end


def tbk_promo
	if self.is_gadz?

		tbk=promo.match(/\A(ai|bo|cl|li|ch|me|an|ka)([0-9]{3})\Z/)[1]

		tbk = "me" if tbk =="ka"

		return Tbk.find_by_diminutif tbk

	end

	nil

end

def default_tbk

	self.tbk_promo || referant.tbk_promo

end

def type_gadz
	if self.is_gadz?
		last_proms=(Date.today-8.months).year

		annee_gadz=last_proms - annee_promo

		return 'PG' if annee_gadz <3
		return 'JP' if annee_gadz <13
		return 'Archi'
	end
end

def serialize
	result=Hash.new

    result[:id]=self.id
    result[:nom]=self.nom_complet
    result[:taillevetement]=self.taillevetement.name if self.taillevetement
    result[:commandes]=self.commandes.map do |c|
      commande=Hash.new
      commande[:ean]=c.ean
      temp=self.chambres.where(event_id: c.event_id).first
	  commande[:chambre]=temp.identifiant if temp
      commande[:event]=c.event ? c.event.name : "EVENT NON RENSEIGNE"
      commande[:annulation]=c.products.any?{|p| p.name=="Annulation"} ? "Oui" : "Non"
      commande[:inter_skipass]=c.products.any?{|p| p.name=="Inter Ski Pass"} ? "Oui" : "Non"
      commande[:rapatriement]=c.products.any?{|p| p.name=="Assistance rapatriement bagages"} ? "Oui" : "Non"
      commande[:tout_compris]=c.products.any?{|p| p.name=="Tout compris"} ? "Oui" : "Non"   
      commande
    end
    result
end

def self.types
	@@types
end

end
