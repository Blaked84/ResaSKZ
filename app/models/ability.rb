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

    can :create, Personne

    can [:read, :update], Personne do |p|
        user.personnes.include? p
    end

    can :read, Paiement do |p|
        user.personnes.map{|p| p.commandes}.flatten.map{|c| c.paiements}.flatten.include?(p)
    end


    can :create, Commande
    can [:read, :update], Commande do |c|
        user.personnes.map{|p| p.commandes}.flatten.include?(c)
    end

    can :read, Event

  end
end
