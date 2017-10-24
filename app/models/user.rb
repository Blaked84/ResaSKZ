class User < ActiveRecord::Base
  rolify

  #################################################
  # Les users / compte => entité se connctant au 
  # site et pouvant avoir en charge plusieurs 
  # commandes de plusieurs personnes
  #################################################

  belongs_to :parrain,  class_name: "User", foreign_key: "parrain_id", inverse_of: :filleuls
  has_many :filleuls,  class_name: "User", foreign_key: "parrain_id", inverse_of: :parrain

  has_many :personnes,  class_name: "Personne", foreign_key: "user_id", dependent: :destroy

  belongs_to :referant, class_name: "Personne", foreign_key: "referant_id"

  #before_save :before_save

  # EXTRACT FROM SCHEMA :
  # create_table "users", force: true do |t|
  #   t.string   "email",                  default: "", null: false
  #   t.string   "encrypted_password",     default: "", null: false
  #   t.string   "reset_password_token"
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.integer  "sign_in_count",          default: 0,  null: false
  #   t.datetime "current_sign_in_at"
  #   t.datetime "last_sign_in_at"
  #   t.string   "current_sign_in_ip"
  #   t.string   "last_sign_in_ip"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.integer  "referant_id"
  #   t.string   "uid"
  #   t.string   "first_name"
  #   t.string   "last_name"
  #   t.string   "gender"
  #   t.boolean  "inscription_terminee"
  #   t.boolean  "cgu_accepted"
  # end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:GadzOrg]

### VALIDATION#################################################################

#### Attributs
  validates :first_name, :length => { :in => 2..30 }
  validates :last_name, :length => { :in => 2..30 }
  validates :gender,:inclusion => {  :in => ['male','female']}

#### Associations

###############################################################################

  def referant_show
    unless self.referant.nil?
      return self.referant.nom_complet
    end
  end

  def nom_complet
    return self.first_name.to_s + " " + self.last_name.to_s
  end

  def get_parrain_nom_complet
    if !self.parrain.nil?
      return self.parrain.referant.nom_complet
    else
      return "Crée par un admin"
    end

  end

  def get_filleuls_number
    if !self.parrain.nil?
     return self.parrain.filleuls.where(moderated: true).count / self.parrain.filleuls.count
    else
      return "--"
    end
  end

  def had_parrain?
    !self.parrain.nil?
  end


  def sync_from_personne(pers)
    self.first_name = pers.prenom
    self.last_name = pers.nom
    self.gender = pers.gender.to_cas
    self.email = pers.email
    self.uid = pers.idGadzOrg

    self.save(:validate => false)

  end

  def admin?
    self.has_role?(:admin)|| self.has_role?(:gorgu)
  end

  def gorgu?
    self.has_role?(:gorgu)
  end

  def gadz?
    has_role? :gadz
  end

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

  def check_pending_reg

    return 'user_path('+id+')' unless inscription_terminee

  end

  def self.limite_inscription?
    return User.all.where(inscription_terminee: true).count-2 > Configurable[:limite_inscription]
  end

  def self.limite_inscription_restant
    return Configurable[:limite_inscription] - User.all.count+2
  end


  #Retrouve un user a partir du UID ou le crée
  def self.omniauth(auth_data, signed_in_resource=nil)
    
    logger.info "=================================="
    logger.info "Connexion depuis le CAS uid : "+auth_data[:uid]
    logger.info "Infos de connection !"
    logger.info auth_data.inspect


    # auth_data : take a look on Users::OmniauthCallbacksController
    if user = User.find_by_uid(auth_data[:uid])
      user
    else
      user = User.new(
        email: auth_data[:info][:email],
        password: Devise.friendly_token[0,20],
        uid: auth_data[:uid],
        first_name: auth_data[:extra][:firstname],
        last_name: auth_data[:extra][:lastname],
        gender: auth_data[:extra][:sex],
        inscription_terminee: false,
        cgu_accepted: false,
        moderated: User.limite_inscription? ? false:true,
        )
      # parce que le cas ne renvoie pas toujours le genre
      user.gender="male" if user.gender.nil?

      user.save!(:validate=>false)

      logger.debug user.inspect
      logger.debug "Erreurs"
      user.errors.each{|k,e| logger.debug k.to_s+" : "+e.to_s}

      pers = user.personnes.new(
        :prenom => auth_data[:extra][:firstname],
        :nom => auth_data[:extra][:lastname],
        :email => auth_data[:info][:email],
        :bucque => auth_data[:extra][:buque_texte].nil? ? nil:auth_data[:extra][:buque_texte] ,
        :fams => auth_data[:extra][:fams].nil? ? nil:auth_data[:extra][:fams] ,
        :promo => (auth_data[:extra][:tbk].nil? or auth_data[:extra][:proms].nil?) ? nil:auth_data[:extra][:tbk]+auth_data[:extra][:proms],
        :type_pers => (auth_data[:extra][:type]=="gadz" and auth_data[:extra][:tbk] != "am") ? "Gadz":"Pec's",
        :moderated => true,
        enregistrement_termine: false
        )

      pers.genre = Genre.from_cas(auth_data[:extra][:sex])
      pers.save!(:validate=>false)
      logger.debug pers.errors.inspect

      user.update_attribute(:referant_id,pers.id)
      user.add_role :gadz

      # user.save!(:validate=>false)

      user
    end
  end
  
public  
  def group_by_date_sqlite
    created_at.to_date.to_s(:db)
  end

end
