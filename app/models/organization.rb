class Organization < ApplicationRecord
  has_many :suppliers, dependent: :destroy

  validates  :name,   length: { maximum: 30, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates  :state_id, numericality: { only_integer: true }, allow_nil: true
  validates  :prefecture_id, numericality: { only_integer: true }, allow_nil: true
  validates  :town_id, numericality: { only_integer: true }, allow_nil: true
  validates  :detail_address,   length: { maximum: 60, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates  :building,   length: { maximum: 60, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :has_event, inclusion: {in: [true, false]}, allow_nil: true
  validates :has_spot, inclusion: {in: [true, false]}, allow_nil: true
  validates :has_activity, inclusion: {in: [true, false]}, allow_nil: true
  validates :has_restaurant, inclusion: {in: [true, false]}, allow_nil: true
  validates :contract_plan, inclusion: {in: [0, 1]}, allow_nil: true
  validates :contract_status, inclusion: {in: [0, 1]}, allow_nil: true
  # validates :post_code, format: { with: /\A\d{3}\-?d{4}\z/ }, allow_nil: true
end
