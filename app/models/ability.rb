class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index], Project
    can :show, Page
    can :show, Translation
    if user
      can [:create,:update], Page
      can :create, Project
      can :show, User
      can [:new,:create,:update], Translation
      can [:show,:update], Sentence
      can [:show,:create], Comment
      can :show, Noticement
      can :edit, Noticement, user_id:user.id
    end
  end
end
