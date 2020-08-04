class User < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects, dependent: :destroy
  # accepts_nested_attributes_for :user_projects, allow_destroy: true

  mount_uploader :avatar, AvatarUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates  :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates  :first_name,   length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates  :last_name,    length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates  :username,     length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates  :profile_text, length: { maximum: 200, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates  :country_id, inclusion: { in: (1..235)}, allow_nil: true
  validates  :language_id, inclusion: { in: (1..28)}, allow_nil: true
  validates  :birth_year, inclusion: { in: (1940..2020)}, allow_nil: true
  validates  :birth_month, inclusion: { in: (1..12)}, allow_nil: true
  validates  :birth_day, inclusion: { in: (1..31)}, allow_nil: true
  validates  :gender, inclusion: { in: ["male", "female", "other"]}, allow_nil: true
  # validates  :phone, numericality: { only_integer: true }, allow_nil: true
  # VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  # validates :phone, format: { with: VALID_PHONE_REGEX }, allow_nil: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable # ,:omniauthable


end
