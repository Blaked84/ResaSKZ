class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    if user.has_role? :gorgu
        can :manage, :all
        can :read_admin, User
    end

    if user.has_role? :admin
        can :manage, :all
        can :read_admin, User
    end

    can :cgu, user
    can :user_infos, user
    can :dashboard, user
    can :parrainer, user if user.has_role? :gadz

    can :create, Personne do |p|
        p.user_id == user.id
    end


    can [:read, :update], Personne do |p|
        p.user_id == user.id
    end

    can [:destroy], Personne do |p|
        p.user_id == user.id && not(p.is_referant?)
    end

    can :create, Paiement do |p|
       p.commande.personne.user_id == user.id
    end 

    can [:create,:read, :update, :add_product, :destroy], Commande do |c|
        pers = Personne.find_by_id(c.personne_id)
        if pers && pers.moderated
            pers.user_id == user.id
        else
            false
        end
    end

    can :create, Commande

    can :read, Event

  end
end
