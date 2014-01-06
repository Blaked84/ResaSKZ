class User < ActiveRecord::Base
  rolify

  #################################################
  # Les users / compte => entité se connctant au 
  # site et pouvant avoir en charge plusieurs 
  # commandes de plusieurs personnes
  #################################################

  has_many :personnes,  class_name: "Personne", foreign_key: "user_id"

  belongs_to :referant, class_name: "Personne", foreign_key: "referant_id"

  before_save :before_save

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:GadzOrg]


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

  def self.omniauth(auth_data, signed_in_resource=nil)
    # auth_data : take a look on Users::OmniauthCallbacksController
    if user = User.find_by_uid(auth_data[:uid])
      user
    else
      user = User.create(
        email: auth_data[:info][:email],
        password: Devise.friendly_token[0,20],
        uid: auth_data[:uid],
        first_name: auth_data[:extra][:firstname],
        last_name: auth_data[:extra][:lastname],
        gender: auth_data[:extra][:sex]
        )

      #AJOUTER Usertype = Gadz

      pers = user.personnes.create(
        :prenom => auth_data[:extra][:firstname],
        :nom => auth_data[:extra][:lastname],
        :email => auth_data[:info][:email],
        :bucque => nil ,
        :fams => nil ,
        :promo => nil
        )

      pers.genre = Genre.from_cas(auth_data[:extra][:sex])

      user
    end
  end

end
