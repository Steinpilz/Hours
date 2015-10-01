class EntryPolicy < ApplicationPolicy
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
    user.admin? || record.user.id == user.id
  end

  def destroy?
    user.admin? || record.user.id == user.id
  end

  class Scope < Scope
    def resolve
      if user.admin?
      	scope.all
      else
      	scope.where(user: user)
      end
    end
  end
end
