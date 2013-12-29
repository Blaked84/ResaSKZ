class Usertype < ActiveRecord::Base
	has_many :personne
	
	attr_accessible :type
end
