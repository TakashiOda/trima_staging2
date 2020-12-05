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
      redirect_to root_path
    else
      @activity = Activity.find(params[:activity_id])
      @book_activity = @cart.booked_activities.build(project_id: @project.id, activity_id: @activity.id, user_id: current_user.id)
      render 'trip_managers/activity_detail'
    end
  end

  def edit
  end

  private
    def booked_activity_params
      params.require(:booked_activity).permit(:project_id, :cart_id, :activity_id,
                                              :user_id, :total_price, :activity_date,
                                              :activity_start_time, { project_member_ids: []})
    end
end
