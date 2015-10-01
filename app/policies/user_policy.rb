class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
      	scope.all
      else
      	scope.where(id: user.id)
      end
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def edit?
    user.admin? || record.id == user.id
  end

  def destroy?
    user.admin? || record.id == user.id
  end
end
