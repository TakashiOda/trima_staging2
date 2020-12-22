class SupplierBookeditemsController < ApplicationController
  before_action :authenticate_supplier!

  def index
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @booked_activities = BookedActivity.where(supplier_id: current_supplier.id)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end

  # def show
  #   @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
  # end
end
