class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? and user.admin?
      can :manage, Slide
      can :manage, Tour
    end
  end
end
