class SupplierProfile < ApplicationRecord
  # relation ************************************
  belongs_to :supplier

  # validation ************************************
  validates :representative_name, presence: true, length: { maximum: 30, message: "最大30文字まで" }
  validates :representative_kana, presence: true, length: { maximum: 30, too_long: "最大30文字まで" }
  validates :manager_name, presence: true, length: { maximum: 30, message: "最大30文字まで" }, allow_blank: true
  validates :manager_name_kana, presence: true, length: { maximum: 30, message: "最大30文字まで" }, allow_blank: true
  validates :prefecture_id, inclusion: { in: 1..47 }
  validates :town_id, inclusion: { in: 1..179 }
  validates :detail_address, presence: true, length: { maximum: 100, message: "最大100文字まで" }
  validates :building, presence: true, length: { maximum: 100, message: "最大100文字まで" }, allow_blank: true
  POSTCODE_REGEX = /\A\d{3}[-]\d{4}\z/
  PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :post_code, presence: true, format: { with: POSTCODE_REGEX, message: "はハイフンあり半角数字のみ" }
  validates :phone, presence: true, format: { with: PHONE_NUMBER_REGEX, message: "はハイフンなしの半角数字10桁、または11桁のみ" }
  validates :contract_plan, presence: true, inclusion: { in: [0, 1, 2] }
  validates :is_suspended, inclusion: { in: [true, false] }

end
