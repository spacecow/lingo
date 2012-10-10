class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index], Project
    can :show, Page
    if user
      can [:create,:update], Page
      can :create, Project
      can :show, User
      can :create, Translation
    end
  end
end
