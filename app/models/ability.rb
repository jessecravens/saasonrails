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
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    if user.has_role?(:admin)
      can [:create, :update, :edit, :destroy], User do |u|
        (u.company == user.company && u.has_any_role?(:employee, :manager) && !u.has_any_role?(:owner, :admin)) || u == user
      end
      can [:new, :index, :show], User, company_id: user.company_id
      can :manage, Profile, user_id: user.id
      can :belongs_to, Company, id: user.company_id
    end

    if user.has_role?(:manager)
      can [:create, :update, :edit, :destroy], User do |u|
        u.company == user.company && u.has_role?(:employee) && !u.has_any_role?(:owner, :admin, :manager) || u == user
      end
      can [:new, :index, :show], User, company_id: user.company_id
      can :manage, Profile, user_id: user.id
      can :belongs_to, Company, id: user.company_id
    end

    if user.has_role?(:owner)
      can :manage, User, company_id: user.company_id
      cannot [:create_token, :destroy_token], company_id: user.company_id
      can :manage, Subscription, company_id: user.company_id
      can :manage, Profile, user: { company_id:  user.company_id }
      can :manage, Company, id: user.company_id
    end
    
    if user.has_role?(:employee)
      can [:read, :update], User, id: user.id
      can :belongs_to, Company, id: user.company_id
    end

    can [:create_token, :destroy_token], User, id: user.id
  end
end
