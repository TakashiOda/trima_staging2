class ActivityBusiness < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :guides, dependent: :destroy
  accepts_nested_attributes_for :guides, allow_destroy: true
  mount_uploader :profile_image, AvatarUploader

end
