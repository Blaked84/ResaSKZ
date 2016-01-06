class Lit < ActiveRecord::Base
	belongs_to :personne
	has_and_belongs_to_many :personnes


	# rend un lit accessible à une personne
	def accesible_a(personne)
		self.personnes << personne
	end

end
