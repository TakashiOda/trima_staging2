class Project < ApplicationRecord
  # belongs_to :country, optional: true
  # has_one :area
  has_many :users, through: :user_projects
  has_many :user_projects
  # accepts_nested_attributes_for :user_projects, allow_destroy: true

  validates :name,  length: { maximum: 20, too_long: "Maximum %{count} characters" }
  validates :start_place,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :end_place,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true

  def is_owner?(user)
    if user_project = UserProject.find_by(project_id: self.id, user_id: user.id) #そもそもuserはメンバーかどうか
      if user_project.control_level = 0 # userは管理者かどうか
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def has_other_members?(user) #user以外のメンバーが存在するか
    if UserProject.where(project_id: self.id).where.not(user_id: user.id).any?
      return true
    else
      return false
    end
  end

  def destroy_last_owner(user)
    UserProject.find_by(project_id: self.id, user_id: user.id).destroy
  end


end
