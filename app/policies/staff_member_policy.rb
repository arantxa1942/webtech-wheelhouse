class StaffMemberPolicy < ApplicationPolicy
  def index?   = signed_in?
  def show?    = signed_in?
  def new?     = create?
  def create?  = owner?
  def edit?    = update?
  def update?  = owner?
  def destroy? = owner?

  class Scope < ApplicationPolicy::Scope
    def resolve = user.present? ? scope.all : scope.none
  end
end