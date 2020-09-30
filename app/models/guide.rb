class Guide < ApplicationRecord
  belongs_to :activity_business
  mount_uploader :avatar, AvatarUploader
end
