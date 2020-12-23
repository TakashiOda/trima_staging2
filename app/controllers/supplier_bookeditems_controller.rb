class SupplierBookeditemsController < ApplicationController
  before_action :authenticate_supplier!

  def index
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @booked_activities = BookedActivity.where(supplier_id: current_supplier.id)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def show
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @booked_activity = BookedActivity.find(params[:id])
    @activity = Activity.find(@booked_activity.activity_id)
    @user = User.find(@booked_activity.user_id)
    @members = @booked_activity.project_members
  end
end
