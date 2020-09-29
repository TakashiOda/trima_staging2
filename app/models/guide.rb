class Guide < ApplicationRecord
  belongs_to :activity_business
  mount_uploader :profile_image, AvatarUploader
end
