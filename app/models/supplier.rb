class Supplier < ApplicationRecord
  # relation ************************************
  has_one :supplier_profile, dependent: :destroy
  accepts_nested_attributes_for :supplier_profile
  has_one :activity_business

  # uploader ************************************
  mount_uploader :avatar, AvatarUploader

  # uploader ************************************
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "形式が正しくありません" }
  validates :encrypted_password, presence: true
  validates :name, length: { maximum: 20, message: "最大20文字まで" }, allow_blank: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable # ,:omniauthable

end
