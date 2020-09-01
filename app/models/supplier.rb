class Supplier < ApplicationRecord
  has_one :supplier_profile

  mount_uploader :avatar, AvatarUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :name,   length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  # validates :control_level, inclusion: { in: [0, 1] }, allow_nil: true
  # validates :accept_invite, inclusion: { in: [0, 1] }, allow_nil: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable # ,:omniauthable

end
