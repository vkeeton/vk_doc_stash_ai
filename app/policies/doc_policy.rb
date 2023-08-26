class DocPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

    def index?
      true
    end

    def new?
      true
    end

    def create?
      true
    end

    def update?
      true
    end

    def doc_delete?
      true
      # record.user == user
    end

    def show?
      # Your logic to determine if the user is allowed to view the document
      true # Or false, depending on your authorization logic
    end
end
