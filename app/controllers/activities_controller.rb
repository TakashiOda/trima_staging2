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
    @activity = @activity_business.activities.build
    @activity.activity_ageprices.build
  end

  def create
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = @activity_business.activities.build(activity_params)
    if @activity.save
      redirect_to supplier_activities_path(current_supplier)
    else
      render 'new'
    end
  end

  def edit
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:id])
  end

  def update
    # binding.pry
    # @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:id])
    if @activity.update(activity_params)
      redirect_to supplier_activities_path(current_supplier)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def stock_new
    # binding.pry
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      if @activity.is_all_year_open
        #通年の体験
        @s_Date = Date.tomorrow
        @e_Date = Date.tomorrow.since(3.month).end_of_month
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
          end
        end
        
      elsif !@activity.is_all_year_open && @activity.start_date && @activity.start_date
        #期間限定の体験
        @s_Date = @activity.start_date
        @e_Date = @activity.end_date
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
          end
        end
      else
        flash[:alert] = '在庫を設定するには体験情報にて期間設定をしてください'
        redirect_to supplier_activities_path(current_supplier)
      end
    else
      flash[:alert] = '在庫を設定するには体験情報のコース時間または期間設定をしてください'
      redirect_to supplier_activities_path(current_supplier)
    end
  end

  private
    def activity_params
      params.require(:activity).permit(:name, :description, :activity_business_id,
                                      :activity_category_id, :main_image, :activity_minutes,
                                      :detail_address, :longitude, :latitude,
                                      :normal_adult_price, :has_season_price,
                                      :maximum_num, :minimum_num, :available_age,  :is_all_year_open,
                                      :start_date, :end_date,
                                      :january, :febrary, :march, :april,
                                      :may, :june, :july, :august, :september, :october,
                                      :november, :december, :advertise_activate, :is_approved,
                                      activity_courses_attributes: [:id, :activity_id, :start_time, :_destroy],
                                      activity_ageprices_attributes: [:id, :activity_id, :age_from,
                                      :age_to, :normal_price, :high_price, :low_price, :_destroy])
    end

    def activity_stock_params
      params.require(:activity).permit(activity_courses_attributes: [:id, :activity_id,
                                       activity_stocks_attributes: [:id, :activity_id, :date,
                                       :course_id, :stock]])
    end


end
