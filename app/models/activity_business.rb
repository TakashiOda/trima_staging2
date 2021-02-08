class ActivityBusiness < ApplicationRecord

  # relation ***********************************************
  belongs_to :supplier
  has_many :activities, dependent: :destroy
  has_many :guides, dependent: :destroy
  accepts_nested_attributes_for :guides, allow_destroy: true

  has_many :activity_languages, dependent: :destroy
  has_many :languages, through: :activity_languages, dependent: :destroy
  accepts_nested_attributes_for :activity_languages, allow_destroy: true

  # uploader ***********************************************
  mount_uploader :profile_image, AvatarUploader
  mount_uploader :insurance_image, InsuranceImageUploader

  # validation ***********************************************
  validates :name, length: { in: 2..40, message: "は2文字以上40文字以下" }, allow_blank: true
  validates :en_name, length: { in: 2..40, message: "は2文字以上40文字以下" }, allow_blank: true
  validates :cn_name, length: { in: 2..40, message: "は2文字以上40文字以下" }, allow_blank: true
  validates :tw_name, length: { in: 2..40, message: "は2文字以上40文字以下" }, allow_blank: true
  validates :profile_text, length: { in: 5..300, message: "は5文字以上300文字以下" }, allow_blank: true
  validates :en_profile_text, length: { in: 5..300, message: "は5文字以上300文字以下" }, allow_blank: true
  validates :cn_profile_text, length: { in: 5..300, message: "は5文字以上300文字以下" }, allow_blank: true
  validates :tw_profile_text, length: { in: 5..300, message: "は5文字以上300文字以下" }, allow_blank: true
  validates :apply_suuplier_address, inclusion: { in: [true, false] }, allow_blank: true
  validates :apply_suuplier_phone, inclusion: { in: [true, false] }, allow_blank: true

  validates :prefecture_id, inclusion: { in: 1..47, message: "が選択されていません" }, if: :not_apply_suuplier_address?, allow_blank: true
  validates :area_id, inclusion: { in: 1..11, message: "が選択されていません" }, if: :not_apply_suuplier_address?, allow_blank: true
  validates :town_id, inclusion: { in: 1..179, message: "が選択されていません" }, if: :not_apply_suuplier_address?, allow_blank: true

  POSTCODE_REGEX = /\A\d{3}[-]\d{4}\z/
  PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :post_code, format: { with: POSTCODE_REGEX, message: "はハイフンあり半角数字のみ" }, allow_blank: true
  validates :phone, format: { with: PHONE_NUMBER_REGEX, message: "はハイフンなし半角数字10桁または11桁のみ" }, allow_blank: true

  validates :detail_address, length: { maximum: 100, message: "は最大100文字まで" }, allow_blank: true
  validates :building, length: { maximum: 100, message: "は最大100文字まで" }, allow_blank: true
  validates :no_charge_cansel_before, inclusion: { in: %w(the_day_before three_days_before a_week_before) }, allow_blank: true
  # validates :status, inclusion: { in: %w(inputting send_approve) }, allow_blank: true
  validates :guide_certification, length: { maximum: 100, message: "は最大100文字まで" }, allow_blank: true
  validates :has_insurance, inclusion: { in: [true, false] }, allow_blank: true
  # validates :insurance_image, presence: true, if: :has_insurance?
  validates :is_approved, inclusion: { in: [true, false] }, allow_blank: true

  # validate :require_any_languages
  # validate :require_any_guides
  # validates :guides, associated: true
  # validates :activity_languages, associated: true

  private

  def has_insurance?
    has_insurance == true
  end

  def not_apply_suuplier_address?
    apply_suuplier_address == false
  end

  def not_apply_suuplier_phone?
    apply_suuplier_phone == false
  end

  def require_any_languages
    errors.add(:activity_languages, 'を選択してください') if activity_languages.blank?
  end
  def require_any_guides
    errors.add(:guides, 'が登録されていません') if guides.blank?
  end

end
