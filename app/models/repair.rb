class Repair < ApplicationRecord
  belongs_to :bike
  belongs_to :staff_member, optional: true
  has_many :repair_services, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :repair_services, allow_destroy: true, reject_if: ->(attrs) { attrs["service_id"].blank? }
  has_many :services, through: :repair_services

  THUMB_SIZE = [120, 90].freeze
  PAGE_SIZE  = [800, 600].freeze

  has_many_attached :intake_photos do |attachable|
    attachable.variant :thumb, resize_to_fill: THUMB_SIZE
    attachable.variant :page,  resize_to_limit: PAGE_SIZE
  end

  enum :status, {
    received: "received", quoted: "quoted", approved: "approved",
    declined: "declined", in_progress: "in_progress",
    ready_for_pickup: "ready_for_pickup", returned: "returned"
  }

  validates :status, presence: true
  validates :received_at, presence: true

  validate :dates_are_consistent
  validate :lifecycle_is_consistent

  scope :open, -> { where(returned_at: nil) }
  scope :overdue, -> { open.where("promised_on < ?", Date.current) }
  scope :newest_first, -> { order(received_at: :desc) }

  def overdue?
    returned_at.nil? && promised_on.present? && promised_on.past?
  end

  def total
    repair_services.sum(:charged_price)
  end

  def photo_alt
    "#{bike.make} #{bike.model}, repair ##{id}"
  end

  private

  def dates_are_consistent
    return if received_at.blank?

    if returned_at.present? && returned_at.to_date < received_at.to_date
      errors.add(:returned_at, "can't be before the day the bike was received")
    end
    if promised_on.present? && promised_on < received_at.to_date
      errors.add(:promised_on, "can't be before the day the bike was received")
    end
  end

  def lifecycle_is_consistent
    errors.add(:returned_at, "can't be set unless the repair has been returned") if returned_at.present? && !returned?

    answered = approved? || declined? || in_progress? || ready_for_pickup? || returned?
    errors.add(:customer_response, "must be recorded once the customer has answered") if answered && customer_response.blank?
  end
end