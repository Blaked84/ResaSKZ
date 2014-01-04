#encoding: utf-8
class Personne < ActiveRecord::Base

	#################################################
	# Les personnes physiques. Appartiennent à un user
	# Les champs précédés de "p" correspondent à la 
	# personne à contacter en cas de problème
	#################################################
	has_many :groupe
	has_many :commande
	has_many :activite
	has_one :genres
	has_one :usertype
	belongs_to :user, :dependent => :destroy  # à vérifier ça...

	#attr_accessible :nom, :prenom, :phone, :email, :assurance

	validates :phone, :format => { :with => /\A((0|\+[1-9]{2})[1-9][0-9]{8})?\Z/ }

#=== Méthodes publiques ==============================================

def nom_complet
    return self.prenom+" "+self.nom
end

def taille_metre
	if self.taille
		return self.taille / 100.0
	end
end

def assure?
	return self.assurance 
end

def document_assurance
	if assure?
		if self.documentassurance
			return "Document fourni"
		else
			return "Docuement à fournir ou en cours de traitement"
		end
	else
		return "Assurance à commander dans les produits"
	end 
end

def p_nom_complet
    return self.pprenom+" "+self.pnom
end


end
