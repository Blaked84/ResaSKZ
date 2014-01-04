class User < ActiveRecord::Base
  rolify

  #################################################
  # Les users / compte => entité se connctant au 
  # site et pouvant avoir en charge plusieurs 
  # commandes de plusieurs personnes
  #################################################

  has_many :commandes
  has_many :personnes,  class_name: "Personne", foreign_key: "user_id"

  belongs_to :referant, class_name: "Personne", foreign_key: "referant_id"

  before_save :before_save

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:cas]


  private

  def before_save

  	ancien = self.new_record? ? User.new :  User.find(self.id)

  	add_to_personnes(self.referant) if self.referant_id != ancien.referant_id

  end

  def add_to_personnes(personne)

  	ancien = self.new_record? ? User.new :  User.find(self.id)

  	if not self.personnes.include?(personne)
  		self.personnes.delete(ancien.referant) if ancien.referant and self.personnes.include?(ancien.referant)
  	end


  	if personne
  		personne.user = self
  		personne.save
  	end

  end

end
