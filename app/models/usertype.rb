class Usertype < ActiveRecord::Base
	#################################################
	# Type: PG / pecs
	#################################################
	
	has_many :personne

	#attr_accessible :type

	def to_s
		return self.type
	end

	def to_str
		return self.type
	end
end
