class CustomerPolicy < ApplicationPolicy
  def index?   = owner? || counter?
  def show?    = owner? || counter?
  def new?     = create?
  def create?  = owner? || counter?
  def edit?    = update?
  def update?  = owner? || counter?
  def destroy? = owner?          

  class Scope < ApplicationPolicy::Scope
    def resolve
      user.present? && (user.owner? || user.counter?) ? scope.all : scope.none
    end
  end
end