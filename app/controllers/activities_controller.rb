class ActivitiesController < ApplicationController
  def index
    @activity_business = ActivityBusiness.find_by(organization_id: current_supplier.organization_id)
    @activities = Activity.where(activity_business_id: @activity_business.id)
  end

  def show
    @activity_business = ActivityBusiness.find_by(organization_id: current_supplier.organization_id)
    @activity = Activity.find(params[:id])
  end

  def new
    @activity_business = ActivityBusiness.find_by(organization_id: current_supplier.organization_id)
    @activity = @activity_business.activities.build
  end

  def create
    @activity_business = ActivityBusiness.find_by(organization_id: current_supplier.organization_id)
    @activity = @activity_business.activities.build(activity_params)
    if @activity.save
      redirect_to activities_path(@activity_business)
    else
      render 'new'
    end
  end

  def edit
    @activity_business = ActivityBusiness.find_by(organization_id: current_supplier.organization_id)
    @activity = Activity.find(params[:id])
  end

  def update
    @activity_business = ActivityBusiness.find_by(organization_id: current_supplier.organization_id)
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
                                      :activity_category_id, :main_image, :state_id,
                                      :prefecture_id, :area_id, :town_id, :detail_address,
                                      :building, :longitude, :latitude,
                                      :maximum_num, :minimum_num, :available_age,
                                      :january, :febrary, :march, :april,
                                      :may, :june, :july, :august, :september, :october,
                                      :november, :december, :advertise_activate, :is_approved)
    end


end
