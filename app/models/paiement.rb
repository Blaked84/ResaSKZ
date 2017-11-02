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
end
