class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? and user.admin?
    end
  end
end
