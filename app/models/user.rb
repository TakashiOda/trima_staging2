class User < ApplicationRecord

  mount_uploader :avatar, AvatarUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :first_name,   length: { maximum: 20, too_long: "Maximum %{count} characters" }
  validates :last_name,    length: { maximum: 20, too_long: "Maximum %{count} characters" }
  validates :username,     length: { maximum: 20, too_long: "Maximum %{count} characters" }
  validates :profile_text, length: { maximum: 200, too_long: "Maximum %{count} characters" }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
end
