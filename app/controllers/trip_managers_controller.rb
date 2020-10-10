class TripManagersController < ApplicationController

  def home
    # binding.pry
    @project = Project.find(params[:project_id])
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    @user_projects = UserProject.where(project_id: @project.id)
    @inviting_users = ProjectInvite.where(project_id: @project.id, has_account: 1)
  end

  def show
  end

  def experience_search
  end
end
