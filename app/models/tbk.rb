class Tbk < ActiveRecord::Base

	#################################################
	# Les TBK gérant les dossiers
	#################################################
	has_many :commande

	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end
end
