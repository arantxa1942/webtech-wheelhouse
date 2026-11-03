class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?   = false
  def show?    = false
  def new?     = false
  def create?  = false
  def edit?    = false
  def update?  = false
  def destroy? = false
  def permitted_attributes = []

 
  def method_missing(name, *args, &block)
    name.to_s.end_with?("?") ? false : super
  end

  def respond_to_missing?(name, include_private = false)
    name.to_s.end_with?("?") || super
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve = scope.none
  end

  private

 
  def signed_in? = user.present?
  def owner?     = user.present? && user.owner?
  def counter?   = user.present? && user.counter?
  def mechanic?  = user.present? && user.mechanic?
end