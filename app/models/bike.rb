class Bike < ApplicationRecord
  belongs_to :customer
  has_many :repairs, -> { newest_first }, dependent: :destroy

  before_validation :normalize_serial_number

  validates :make, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :serial_number, presence: true, uniqueness: true

  scope :by_make_and_model, -> { order(:make, :model) }

  private

  def normalize_serial_number
    self.serial_number = serial_number.to_s.strip.upcase if serial_number.present?
  end
end