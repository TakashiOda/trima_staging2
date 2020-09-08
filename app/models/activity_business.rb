class ActivityBusiness < ApplicationRecord
  has_many :activities, dependent: :destroy
  mount_uploader :profile_image, AvatarUploader

end
