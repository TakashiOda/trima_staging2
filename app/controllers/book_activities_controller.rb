class BookActivitiesController < ApplicationController
  before_action :authenticate_user!
  require 'securerandom'

  def new
  end

  def create
    purchase_number = SecureRandom.alphanumeric(8)
    @project = Project.find(params[:project_id])
    if @project.cart.nil?
      @cart = @project.build_cart
    else
      @cart = @project.cart
    end
    @booked_activity = @cart.booked_activities.build(booked_activity_params)
    @booked_activity.purchase_number = SecureRandom.alphanumeric(10)
    @booked_activity.activity_name = @booked_activity.activity.name
    @booked_activity.activity_end_time = @booked_activity.activity_start_time + (@booked_activity.activity.activity_minutes).minutes
    @booked_activity.join_members_num = @booked_activity.project_members.size
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
      redirect_to project_cart_path(@project)
    else
      render 'trip_managers/cart'
    end
  end

  private
    def booked_activity_params
      params.require(:booked_activity).permit(:project_id, :cart_id, :activity_id, :activity_name,
                                              :user_id, :user_name, :join_members_num,
                                              :total_price, :activity_date,
                                              :activity_start_time, :activity_end_time,
                                              { project_member_ids: []}, :supplier_id)
    end
end
