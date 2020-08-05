class Project < ApplicationRecord
  # belongs_to :country, optional: true
  # has_one :area
  has_many :users, through: :user_projects
  has_many :user_projects, dependent: :destroy
  accepts_nested_attributes_for :user_projects, allow_destroy: true

  validates :name,  length: { maximum: 20, too_long: "Maximum %{count} characters" }
  validates :start_place,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :end_place,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true

  def send_invite_email(email_params, inviter)
   UserInvitationMailer.user_invitation(email_params, inviter).deliver_now
  end

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

  def add_member(email_params, inviter)
    unless email_params.blank?
      @member = User.find_by(email: email_params)
      unless @member.nil?
        @membership = UserProject.new(project_id: self.id, user_id: @member.id,
                                           control_level: 1, accept_invite: 1)
        @membership.save!
      else
        ProjectInvite.create(project_id: self.id, inviter_id: inviter.id, invited_email: email_params)
        self.send_invite_email(email_params, inviter)
      end
    end
  end

  def replace_member(email_params, inviter)
    unless email_params.blank?
      @member = User.find_by(email: email_params)
      # メールアドレスに該当するユーザーが存在するか
      unless @member.nil?
        @membership = UserProject.find_by(project_id: self.id, user_id: @member.id)
        # ユーザーがまだプロジェクトに加入していない
        unless @membership
          @membership = UserProject.new(project_id: self.id, user_id: @member.id,
                                             control_level: 1, accept_invite: 1)
          @membership.save!
        end
      else
        ProjectInvite.create(project_id: self.id, inviter_id: inviter.id, invited_email: email_params)
        self.send_invite_email(email_params, inviter)
      end
    end
  end

  def add_me_as_admin(user)
    @ownership = UserProject.new(project_id: self.id, user_id: user.id,
                                       control_level: 0, accept_invite: 0)
    @ownership.save!
  end


end
