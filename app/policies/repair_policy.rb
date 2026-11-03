class RepairPolicy < ApplicationPolicy
  FULL_ATTRIBUTES = [
    :bike_id, :staff_member_id, :status, :received_at, :quoted_at,
    :promised_on, :returned_at, :customer_response, :customer_responded_at,
    :diagnosis,
    { intake_photos: [] },
    { repair_services_attributes: [ :id, :service_id, :charged_price, :_destroy ] }
  ].freeze

  MECHANIC_ATTRIBUTES = [ :status, :diagnosis, { intake_photos: [] } ].freeze

  def index?   = signed_in?  
  def show?    = owner? || counter? || own_repair?
  def new?     = create?
  def create?  = owner? || counter?
  def edit?    = update?

  def update?
    return true if owner?
    return false if record.returned?   
    counter? || own_repair?
  end

  def destroy? = owner?


  def destroy_photo?
    owner? || (counter? && !record.returned?)
  end

  def permitted_attributes
    if owner? || counter? then FULL_ATTRIBUTES
    elsif mechanic?       then MECHANIC_ATTRIBUTES
    else []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.owner? || user.counter?
      return scope.where(staff_member_id: user.staff_member_id) if user.mechanic? && user.staff_member_id.present?

      scope.none
    end
  end

  private

  def own_repair?
    mechanic? && user.staff_member_id.present? &&
      record.staff_member_id == user.staff_member_id
  end
end