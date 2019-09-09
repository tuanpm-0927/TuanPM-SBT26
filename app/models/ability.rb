class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? and user.admin?
      can :manage, Category
      can :manage, Tour
    end
  end
end
