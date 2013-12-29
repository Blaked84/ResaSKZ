class Chambre < ActiveRecord::Base
	# il faut prévoir que les chambres sont louées 2 fois
	has_one :groupe

	#attr_accessible :numero, :nbrplace
end
