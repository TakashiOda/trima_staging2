class User < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects, dependent: :destroy
  # accepts_nested_attributes_for :user_projects, allow_destroy: true
  has_many :favorite_activities, dependent: :destroy

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

  def own_projects
    own_pro_ids = UserProject.where(user_id: self.id, control_level: 0).pluck(:project_id)
    @owns = []
    own_pro_ids.each do |own_pro_id|
      own_project = Project.find(own_pro_id)
      @owns.push(own_project)
    end
    return @owns
  end

  def invited_projects
    invited_pro_ids = UserProject.where(user_id: self.id, control_level: 1 ,accept_invite: 0).pluck(:project_id)
    @inviteds = []
    invited_pro_ids.each do |invited_pro_id|
      accept_project = Project.find(invited_pro_id)
      # 管理者のいない幽霊Projectは入れない
      project_owners = UserProject.where(project_id: invited_pro_id, control_level: 0)
      if project_owners.any?
        @inviteds.push(accept_project)
      else
        accept_project.destroy!
      end
    end
    return @inviteds
  end

  def waiting_projects
    waiting_pro_ids = UserProject.where(user_id: self.id, control_level: 1, accept_invite: 1).pluck(:project_id)
    @waitings = []
    waiting_pro_ids.each do |waiting_pro_id|
      wait_project = Project.find(waiting_pro_id)
      project_owners = UserProject.where(project_id: waiting_pro_id, control_level: 0)
      if project_owners.any?
        @waitings.push(wait_project)
      else
        wait_project.destroy!
      end
    end
    return @waitings
  end
end
