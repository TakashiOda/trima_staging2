class BookActivitiesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @project = Project.find(params[:project_id])
    if @project.cart.nil?
      @cart = @project.build_cart
    else
      @cart = @project.cart
    end
    @cart = @project.cart
    @booked_activity = @cart.booked_activities.build(booked_activity_params)
    if @booked_activity.save
      redirect_to project_cart_path(@project)
    else
      @activity = Activity.find(params[:activity_id])
      @book_activity = @cart.booked_activities.build(project_id: @project.id, activity_id: @activity.id, user_id: current_user.id)
      render 'trip_managers/activity_detail'
    end
  end

  def edit
  end

  def destroy
    @project = Project.find(params[:project_id])
    @cart = @project.cart
    @activity = Activity.find(params[:activity_id])
    @booked_activity = BookedActivity.find(params[:id])
    if @booked_activity.destroy
      # @booked_activities = @cart.booked_activities
      redirect_to project_cart_path(@project)
    else
      render 'trip_managers/cart'
    end
  end

  private
    def booked_activity_params
      params.require(:booked_activity).permit(:project_id, :cart_id, :activity_id,
                                              :user_id, :total_price, :activity_date,
                                              :activity_start_time, { project_member_ids: []})
    end
end
