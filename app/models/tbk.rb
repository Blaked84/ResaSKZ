class Tbk < ActiveRecord::Base
	has_many :commande

	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end
end
