class Lit < ActiveRecord::Base
	#belongs_to :personne
	has_one :personne
	has_and_belongs_to_many :personnes
	belongs_to :chambre


	# rend un lit accessible à une personne
	def set_accesible_a(personne)
		self.personnes << personne
	end

end
