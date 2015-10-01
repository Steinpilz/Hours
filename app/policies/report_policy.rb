class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
      	scope.all
      else
      	scope.where(id: -1)
      end
    end
  end
end
