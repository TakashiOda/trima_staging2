class ActivityBusiness < ApplicationRecord

  # relation ***********************************************
  belongs_to :supplier
  has_many :activities, dependent: :destroy
  has_many :guides, dependent: :destroy
  accepts_nested_attributes_for :guides, allow_destroy: true

  has_many :activity_languages
  has_many :languages, through: :activity_languages
  accepts_nested_attributes_for :activity_languages

  # uploader ***********************************************
  mount_uploader :profile_image, AvatarUploader
  mount_uploader :insurance_image, InsuranceImageUploader

  # validation ***********************************************
  validates :name, presence: true, length: { in: 2..50, message: "2文字以上50文字以下" }
  validates :en_name, length: { in: 2..50, message: "2文字以上50文字以下" }, allow_blank: true
  validates :cn_name, length: { in: 2..50, message: "2文字以上50文字以下" }, allow_blank: true
  validates :tw_name, length: { in: 2..50, message: "2文字以上50文字以下" }, allow_blank: true
  validates :profile_text, presence: true, length: { in: 5..300, message: "5文字以上300文字以下" }
  validates :en_profile_text, length: { in: 5..300, message: "5文字以上300文字以下" }, allow_blank: true
  validates :cn_profile_text, length: { in: 5..300, message: "5文字以上300文字以下" }, allow_blank: true
  validates :tw_profile_text, length: { in: 5..300, message: "5文字以上300文字以下" }, allow_blank: true
  validates :apply_suuplier_address, inclusion: { in: [true, false] }
  validates :apply_suuplier_phone, inclusion: { in: [true, false] }

  VALID_POSTCODE_REGEX = /\A\d{3}[-]\d{4}\z/
  validates :email, format: { with: VALID_POSTCODE_REGEX, message: "ハイフンあり半角数字のみ" }
  validates :post_code, inclusion: { in: [true, false] }, allow_blank: true
  validates :phone, inclusion: { in: [true, false] }, allow_blank: true

  validates :detail_address, length: { maximum: 100, too_long: "最大%{count}文字まで" }, allow_blank: true
  validates :building, length: { maximum: 100, too_long: "最大%{count}文字まで" }, allow_blank: true
  validates :no_charge_cansel_before, inclusion: { in: %w(the_day_before three_days_before a_week_before) }
  validates :status, inclusion: { in: %w(inputing send_approve) }
  validates :guide_certification, length: { maximum: 100, too_long: "最大%{count}文字まで" }, allow_blank: true
  validates :has_insurance, inclusion: { in: [true, false] }
  validates :is_approved, inclusion: { in: [true, false] }

end
