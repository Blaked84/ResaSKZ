class Activite < ActiveRecord::Base
	#################################################
	# Activitée auxquelles le pg/pec's peuvent 
	# s'inscrire
	#################################################

	has_many :personnes, through: :activites_personnes
  has_many :activites_personnes, dependent: :destroy
  belongs_to :event

	#attr_accessible :nom

  def to_s
  	return self.nom
  end

  def to_str
    return self.nom
  end

  def import_from_product(productid)
  	personnes=Product.find(productid).commandes.map{ |c| c.personne}
  	product=Product.find(productid)
  	# récupération des infos
  	self.nom = product.name
  	self.event_id = product.event_id
  	# pour reconnaitre les activité importées depuis un produit
  	self.productid = product.id 

  	#ajout des personnes
  	personnes.each{|p| self.add_personne(p.id)} unless !personnes.any?
  end

  def import_from_cat_product(categorieid,eventid)
    categorie=Categorie.find(categorieid)
    categorie.products.each{ |p|  self.import_from_product(p.id) if p.event_id=eventid}
    self.nom = categorie.nom
    self.event_id = eventid
    self.productid = 1000 + categorieid.to_i
  end

  def add_personne(personneid)
  	self.personnes << Personne.find(personneid)
  end

  def check_personne(personneid)
    activiteid=self.id
    ap=ActivitesPersonne.where(activite_id: activiteid ).find_by! personne_id: personneid
    ap.checked=true
    ap.save
  end

  def is_checked?(personneid)
    activiteid=self.id
    ap=ActivitesPersonne.where(activite_id: activiteid ).find_by! personne_id: personneid
    return ap.checked
  end

  def serialize
    result=Hash.new

    result[:id]=self.id
    result[:nom]=self.nom
    result[:event]=self.event ? self.event.name : "EVENT NON RENSEIGNE"
    result[:open]=self.open ? "LIBRE" : "RESA"
    result[:personnes]=self.activites_personnes.map do |ap|
      personne=Hash.new
      personne[:infos]=ap.personne.infos_completes
      temp_com=ap.personne.commandes.where(event_id:self.event_id).first
      personne[:commande]=temp_com.idlong if temp_com
      temp_chambre=ap.personne.chambres.where(event_id:self.event_id).first
      personne[:chambre]=temp_chambre.identifiant if temp_chambre
      personne[:checked]=ap.checked ? "Oui" : "Non"
      personne
    end
    result

  end

end
