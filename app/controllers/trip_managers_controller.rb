class TripManagersController < ApplicationController

  def home
    @project = Project.find(params[:project_id])
    @areas = @project.areas
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    @user_projects = UserProject.where(project_id: @project.id)
    @inviting_users = ProjectInvite.where(project_id: @project.id, has_account: 1)
  end

  def search_home
    @project = Project.find(params[:project_id])
    @areas = @project.areas
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    @user_projects = UserProject.where(project_id: @project.id)
    @inviting_users = ProjectInvite.where(project_id: @project.id, has_account: 1)
    @activities = Activity.all
  end

  def activity_detail
    @project = Project.find(params[:project_id])
    @activity = Activity.find(params[:activity_id])
    if @project.cart.nil?
      @cart = @project.build_cart
    else
      @cart = @project.cart
    end
    @book_activity = @cart.booked_activities.build(activity_id: @activity.id)
  end

  def experience_search
  end
end
