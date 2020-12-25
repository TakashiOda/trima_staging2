class SupplierBookeditemsController < ApplicationController
  before_action :authenticate_supplier!

  def index_future
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @booked_activities = BookedActivity.where(supplier_id: current_supplier.id).where('activity_date >= ?', Date.today)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def index_past
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @booked_activities = BookedActivity.where(supplier_id: current_supplier.id).where('activity_date < ?', Date.today)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def index_all
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @booked_activities = BookedActivity.where(supplier_id: current_supplier.id)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def show
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @booked_activity = BookedActivity.find(params[:id])
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
    @gain_price = (@booked_activity.total_price - (@booked_activity.total_price * 0.15)).to_i
    @activity = Activity.find(@booked_activity.activity_id)
    @user = User.find(@booked_activity.user_id)
    @members = @booked_activity.project_members
  end
end
