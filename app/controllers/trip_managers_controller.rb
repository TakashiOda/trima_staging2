class TripManagersController < ApplicationController
  before_action :authenticate_user!, except: [:activity_detail]

  def home
    @project = Project.find(params[:project_id])
    # @areas = @project.areas
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    # @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    @user_projects = UserProject.where(project_id: @project.id)
    # @inviting_users = ProjectInvite.where(project_id: @project.id, has_account: 1)
  end

  def search_home
    @project = Project.find(params[:project_id])
    # @areas = @project.areas
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    # @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    @user_projects = UserProject.where(project_id: @project.id)
    # @inviting_users = ProjectInvite.where(project_id: @project.id, has_account: 1)
    @activities = Activity.all
  end

  def activity_detail
    @project = Project.find(params[:project_id])
    @activity = Activity.find(params[:activity_id])

    @courses = @activity.activity_courses
    @stocks = @courses[0].activity_stocks
    # @adult_ageprices = []
    @ageprice = @activity.activity_ageprices.order(:age_from).limit(1)[0]
    if @project.cart.nil?
      @cart = @project.build_cart
      @cart.save!
    else
      @cart = @project.cart
    end
    # binding.pry
    if current_user
      @book_activity = @cart.booked_activities.build(project_id: @project.id, activity_id: @activity.id, user_id: current_user.id)
    else
      @book_activity = @cart.booked_activities.build(project_id: @project.id, activity_id: @activity.id)
    end
  end

  def cart
    @project = Project.find(params[:project_id])
    if @project.cart.nil?
      @cart = @project.build_cart
      @cart.save!
    else
      @cart = @project.cart
      @booked_activities = @cart.booked_activities
    end

  end

  def experience_search
  end
end
