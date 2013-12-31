class Chambre < ActiveRecord::Base
	#################################################
    # Les chambres: on leur attribue des personnes
	#################################################


	# il faut prévoir que les chambres sont louées 2 fois
	has_one :groupe

	#attr_accessible :numero, :nbrplace

	def to_s
  	return self.numero
  end

  def to_str
    return self.numero
  end
  
end
