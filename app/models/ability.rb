# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    return unless user.present?
    case controller_namespace
    when Setting.admin
      can :manage, :all if user.admin?
    else
      can [:show], User, user_id: user.id
      can :read, :admin_home if user.admin?
    end
  end
end
