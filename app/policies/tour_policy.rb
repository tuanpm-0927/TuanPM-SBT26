class TourPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    check_user
  end

  def new?
    check_user
  end

  def create?
    check_user
  end

  def update?
    check_user
  end

  def show?
    check_user
  end

  def edit?
    check_user
  end

  def destroy?
    check_user
  end
  
  private
  def check_user
    @user.admin?
  end
end
