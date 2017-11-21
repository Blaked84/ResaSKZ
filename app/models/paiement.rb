class Paiement < ActiveRecord::Base

	#################################################
	# Regroupe les différentes transactions liée aux
	# commandes. Il peut y avour plusieurs transactions
	# par commande. "amount_cent" est le montant du
	# paiement en centimes.
	#################################################

	# à ajouter en base:
	# - hash pour le numero de transaction unique
	# - status = false par defaut et = true quand
	#   il y a confirmation de la banque que le paiement
	#   est accepté


	belongs_to :commande

	validates :idlong, uniqueness: true

	def amount_euro
		return self.amount_cents.to_i / 100.0
	end
	def date
		return self.created_at
	end

	def set_verif
		self.verif=true
		self.verified_at = DateTime.now
		self.save
	end

	def set_unverif
		self.verif=false
		self.verified_at = DateTime.now
		self.save
	end

	def set_erreur(code)
		self.erreur=code.to_i
		self.save
	end

	def erreur?
		if !self.erreur.nil? || !self.erreur==0
			return true
		else
			return false
		end
	end

	def verif?
		self.verif && !self.erreur?
	end

	def forced?
		self.verif_forced
	end

	def force_valid(userid)
		self.verif_forced=true
		self.verified_by=userid
		if self.en_attente
			self.en_attente = false
                end
		self.save

		set_verif
	end

	def gen_idlong
		(SecureRandom.random_number *10**14).to_s[0,13]
	end
	
	def serialize
		pers = self.commande.personne
		result = Hash.new
		result[:id]=self.commande.id
		result[:idlong]=self.commande.idlong
		result[:event]=self.commande.event ? self.event.name : "EVENT NON RENSEIGNE"

		if pers
			result[:email]=pers.email
			result[:nom]=pers.nom
			result[:prenom]=pers.prenom
			result[:bucque]=pers.bucque
			result[:nums]=pers.fams
			result[:promo]=pers.promo
			result[:tel]=pers.phone
			result[:taille]=pers.taille
			result[:pointure]=pers.pointure
			result[:vetement]=pers.taillevetement.name if pers.taillevetement
			temp=pers.chambres.where(event_id: self.event_id).first
			result[:chambre]=temp.identifiant if temp
			result[:typeresid]=pers.typeresid.name if pers.typeresid.present?
			result[:lit]=pers.lit.name if pers.lit.present?
		end

		result[:tbk]=self.commande.tbk ? self.commande.tbk.nom_complet : "AUCUN"

		result[:paiement1]= self.commande.etape_valide?(1.to_i) ? "OUI" : "NON"
		result[:paiement2]= self.commande.etape_valide?(2.to_i) ? "OUI" : "NON"
		result[:paiement3]= self.commande.paiementok? ? "OUI" : "NON"

		products= Hash.new
		Categorie.all.each do|c|
			if not(c.max_par_personne) || c.max_par_personne > 1
				c.products.each do |p|
					cp=self.commande_products.select{|cp| cp.product_id==p.id}.first
					products[p.name+"- semaine "+p.event_id.to_s]=cp ? cp.nombre : 0
				end
			else
				cp = self.commande_products.select{|cp| cp.product.categorie_id==c.id}.first
				products[c.nom]= cp ? cp.product.name : 0
			end
		end

		result[:products]=products
		result[:complete]= self.commande.complete? ? "OUI" : "NON"

		return result
	end
end
