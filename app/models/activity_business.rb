class ActivityBusiness < ApplicationRecord
  belongs_to :supplier
  has_many :activities, dependent: :destroy
  has_many :guides, dependent: :destroy
  accepts_nested_attributes_for :guides, allow_destroy: true

  has_many :activity_languages
  has_many :languages, through: :activity_languages
  accepts_nested_attributes_for :activity_languages

  mount_uploader :profile_image, AvatarUploader
  mount_uploader :insurance_image, InsuranceImageUploader

end
