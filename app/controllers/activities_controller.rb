class ActivitiesController < ApplicationController
  def index
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activities = Activity.where(activity_business_id: @activity_business.id)
  end

  def show
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:id])
  end

  def new
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    # @activity = current_supplier.activities.build
    @activity = @activity_business.activities.build
    @activity.activity_ageprices.build
  end

  def create
    # binding.pry
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = @activity_business.activities.build(activity_params)
    if @activity.save
      redirect_to activities_path(@activity_business)
    else
      render 'new'
    end
  end

  def edit
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:id])
  end

  def update
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:id])
    if @activity.update(activity_params)
      redirect_to activities_path(@activity_business)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def activity_params
      params.require(:activity).permit(:name, :description, :activity_business_id,
                                      :activity_category_id, :main_image, :activity_minutes,
                                      :detail_address, :longitude, :latitude,
                                      :price, :has_season_price, :low_price_ratio, :high_price_ratio,
                                      :maximum_num, :minimum_num, :available_age,
                                      :january, :febrary, :march, :april,
                                      :may, :june, :july, :august, :september, :october,
                                      :november, :december, :advertise_activate, :is_approved,
                                      activity_courses_attributes: [:id, :activity_id, :start_time, :_destroy],
                                      activity_ageprices_attributes: [:id, :activity_id, :age_from, :age_to, :price, :_destroy])
    end


end
