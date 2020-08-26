class ActivityBusiness < ApplicationRecord
  belongs_to :organization
  has_many :activities, dependent: :destroy

  mount_uploader :profile_image, AvatarUploader

end
