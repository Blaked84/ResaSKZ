class Activite < ActiveRecord::Base
	#################################################
	# Activitée auxquelles le pg/pec's peuvent 
	# s'inscrire
	#################################################

	has_and_belongs_to_many :personnes

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

  def add_personne(personneid)
  	self.personnes << Personne.find(personneid)
  	#let's code baby!
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
end
