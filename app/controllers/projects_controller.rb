class ProjectsController < ApplicationController
  before_action :authenticate_user!
  attr_reader :invite_emails

  def index
    @owns = current_user.own_projects #Userのモデルメソッド
    @inviteds = current_user.invited_projects #Userのモデルメソッド
    @waitings = current_user.waiting_projects #Userのモデルメソッド
  end

  def show
    @project = Project.find(params[:id])
    @owner = User.find(UserProject.find_by(project_id: params[:id], control_level: 0).user_id)
    @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    @user_projects = UserProject.where(project_id: @project.id)
    @inviting_users = ProjectInvite.where(project_id: @project.id, has_account: 1)
  end

  def accept_project
    @user_project = UserProject.find_by(user_id: current_user.id, project_id: params[:id])
    @user_project.accept_invite = 0
    if @user_project.save
      flash[:notice] = 'You Accepted Project!'
      redirect_to user_project_path(current_user, params[:id])
    else
      render 'show'
    end
  end

  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.build
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.add_member(params[:invite_emails][:member], current_user) #Projectのモデルメソッド
      @project.add_member(params[:invite_emails][:member2], current_user) #Projectのモデルメソッド
      @project.add_member(params[:invite_emails][:member3], current_user) #Projectのモデルメソッド
      @project.add_member(params[:invite_emails][:member4], current_user) #Projectのモデルメソッド
      @project.add_me_as_admin(current_user)
      redirect_to user_projects_path(current_user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @project = Project.find(params[:id])
    @members = UserProject.where(project_id: @project.id).where.not(user_id: current_user.id )
    @inviting_members = ProjectInvite.where(project_id: @project.id, has_account: 1)
    @left_invite_num = 4 - @members.count - @inviting_members.count
  end

  def update
    # binding.pry
    @user = User.find(params[:user_id])
    @project = Project.find(params[:id])
    if @project.update(project_params)
      @project.replace_member(params[:invite_emails][:member], current_user) #Projectのモデルメソッド
      @project.replace_member(params[:invite_emails][:member2], current_user) #Projectのモデルメソッド
      @project.replace_member(params[:invite_emails][:member3], current_user) #Projectのモデルメソッド
      @project.replace_member(params[:invite_emails][:member4], current_user) #Projectのモデルメソッド
      redirect_to user_project_path(@user, @project)
    else
      render 'edit'
    end
  end

  def member_delete
    @member = UserProject.find_by(user_id: params[:member_id], project_id: params[:id])
    if @member.destroy
      flash[:notice] = 'Member Deleted!'
      redirect_to user_project_path(current_user, params[:id])
    else
      flash[:alert] = 'Permission denied!'
      render 'show'
    end
  end

  def invitation_delete
    @invitation = ProjectInvite.find(params[:invite_id])
    if @invitation.destroy!
      redirect_to user_project_path(current_user, params[:id])
    else
      render 'show'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @project = Project.find(params[:id])
    if @project.is_owner?(current_user) # current_userは管理者かどうか is_owner?はモデルメソッド
      unless @project.has_other_members?(current_user) # 他のメンバーが存在しないかどうか　has_other_members?はモデルメソッド
        @project.destroy_last_owner(current_user) #
        @project.destroy
        flash[:notice] = "Project has been Deleted!"
        redirect_to user_projects_path(@user)
      else
        flash[:alert] = "At first, please delete members"
        render 'edit'
      end
    else
      flash[:alert] = "Permission denied! You are not owner!"
      render 'edit'
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :start_date, :end_date,
                                      :start_place, :end_place,
                                      :destination_area_id, { invite_emails: [] })
    end

    def member_destroy_params
      params.require(:project).permit(:id, :user_id, :member_id)
    end

end
