class ServicePolicy < ApplicationPolicy
  def index?   = true   
  def show?    = true   
  def new?     = create?
  def create?  = owner?
  def edit?    = update?
  def update?  = owner?
  def destroy? = owner?

  class Scope < ApplicationPolicy::Scope
    def resolve = scope.all
  end
end