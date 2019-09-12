# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    can :manage, User, id: user.id
  end
end
