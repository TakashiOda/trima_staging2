class Guide < ApplicationRecord
  # relation ***********************************************
  belongs_to :activity_business
  # uploader ***********************************************
  mount_uploader :avatar, AvatarUploader
  # validation ***********************************************
  validates :avatar, presence: true
  validates :name, presence: true, length: { in: 1..40, message: "は2文字以上40文字以下" }
  validates :roll, length: { maximum: 100, message: "は100文字以下" }
  validates :introduction, length: { maximum: 200, message: "は200文字以下" }

end
