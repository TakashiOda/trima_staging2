class ActivityBusinessesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @supplier = current_supplier
    @organization = Organization.find(current_supplier.organization_id)
    # @business = @organization.activity_businesses.build
    @activity_business = ActivityBusiness.new(organization_id: @organization.id)
  end

  def edit
  end
end
