class Usertype < ActiveRecord::Base
	#################################################
	# Type: PG / pecs
	#################################################

	has_many :personnes,  class_name: "Personne", foreign_key: "usertype_id"

	#attr_accessible :type

	def to_s
		return self.type
	end

	def to_str
		return self.type
	end
end
