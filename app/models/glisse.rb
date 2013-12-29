class Glisse < ActiveRecord::Base
	has_many :commande

	#attr_accessible :nom
	
	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end
end
