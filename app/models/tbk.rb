class Tbk < ActiveRecord::Base

	#################################################
	# Les TBK gérant les dossiers
	#################################################
	has_many :commandes
	has_many :chambres

	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end

	def nom_complet
		return nom+" (#{nom_pecs})"
	end
end
