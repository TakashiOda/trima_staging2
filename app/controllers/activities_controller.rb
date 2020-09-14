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
    binding.pry
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


  def stock_new_first_month
    # binding.pry
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      if @activity.is_all_year_open
        #通年の体験
        #当月分の在庫 new
        @s_Date = Date.today #体験の開始日
        @e_Date = Date.today.end_of_month #当月の末日
        # @e_Date = Date.today.since(3.month).end_of_month
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            # @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
          end
        end

      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date
        #期間限定の体験
        @s_Date = @activity.start_date # start_dateが来月の場合もある
        if @activity.end_date < @activity.start_date.end_of_month
          @e_Date = @activity.end_date
        else
          @e_Date = @activity.start_date.end_of_month #end_dateが月末より前の可能性がある
        end

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

  def stock_new_next_month
    # binding.pry
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      if @activity.is_all_year_open
        #通年の体験
        #当月分の在庫 new
        @s_Date = Date.today.end_of_month + 1 #翌月1日
        @e_Date = @s_Date.end_of_month #翌月末
        # @e_Date = Date.today.since(3.month).end_of_month
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            # @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
          end
        end

      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date
        #期間限定の体験
        @s_Date = @activity.start_date.end_of_month + 1 # start_dateが来月の場合もある
        if @activity.end_date <= (@activity.start_date >> 1).end_of_month
          @e_Date = @activity.end_date
        else
          @e_Date = (@activity.start_date >> 1).end_of_month #end_dateが月末より前の可能性がある
        end

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

  def stock_new_next2_month
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      if @activity.is_all_year_open
        #通年の体験
        #当月分の在庫 new
        @s_Date = (Date.today >> 1).end_of_month + 1 #翌月1日
        @e_Date = @s_Date.end_of_month #翌月末
        # @e_Date = Date.today.since(3.month).end_of_month
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            # @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
          end
        end

      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date
        #期間限定の体験
        @s_Date = (@activity.start_date >> 1).end_of_month + 1 # start_dateが来月の場合もある
        if @activity.end_date <= (@activity.start_date >> 2).end_of_month
          @e_Date = @activity.end_date
        else
          @e_Date = (@activity.start_date >> 2).end_of_month #end_dateが月末より前の可能性がある
        end

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

  def stock_new_next3_month
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      if @activity.is_all_year_open
        #通年の体験
        #当月分の在庫 new
        @s_Date = (Date.today >> 2).end_of_month + 1 #翌月1日
        @e_Date = @s_Date.end_of_month #翌月末
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            # @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
          end
        end

      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date
        #期間限定の体験
        @s_Date = (@activity.start_date >> 2).end_of_month + 1 # start_dateが来月の場合もある
        if @activity.end_date <= (@activity.start_date >> 3).end_of_month
          @e_Date = @activity.end_date
        else
          @e_Date = (@activity.start_date >> 3).end_of_month #end_dateが月末より前の可能性がある
        end

        # @s_Date = (@activity.start_date >> 2).end_of_month + 1
        # @e_Date = @s_Date.end_of_month
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


  def stock_edit_first_month
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      @latest_stock_date = ActivityStock.where(activity_id: 1).order(:date).last.date
      if @activity.is_all_year_open #　通年の体験
        if @latest_stock_date >= Date.today.end_of_month # 今月すでに在庫を月末まで作成していたら
          @s_Date = Date.today
          @e_Date = Date.today.end_of_month
          # @courses.each do |course|
          #   (@s_Date..@e_Date).each do |date|
          #     @stock = course.activity_stocks
          #   end
          # end
        else #今月分に未作成の在庫がある場合
          render 'stock_new_first_month'
        end
      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date
        # 期間限定の体験
        if @latest_stock_date >= Date.today.end_of_month #今月分の在庫は作成済 ここエラー
          if @activity.start_date > Date.today
            @s_Date = @activity.start_date
          else
            @s_Date = Date.today
          end

          if @activity.end_date < Date.today.end_of_month
            @e_Date = @activity.end_date
          else
            @e_Date = Date.today.end_of_month
          end
          # @courses.each do |course|
          #   (@s_Date..@e_Date).each do |date|
          #     @stocks = ActivityStock.where(activity_course_id: course.id, date: date)
          #     # @stock = course.activity_stocks.find_by(date: date)
          #   end
          # end
        elsif @latest_stock_date >= Date.today && @latest_stock_date < Date.today.end_of_month
          if @activity.start_date > Date.today
            @exist_stock_s_Date = @activity.start_date
          else
            @exist_stock_s_Date = Date.today
          end
          @exist_stock_e_Date = @latest_stock_date
          #
          # @courses.each do |course|
          #   (@exist_stock_s_Date..@exist_stock_e_Date).each do |date|
          #     @stock = course.activity_stocks
          #   end
          # end

          @s_Date = @latest_stock_date + 1
          if @activity.end_date > Date.today.end_of_month
            @e_Date = Date.today.end_of_month
          else
            @e_Date = @activity.end_date
          end
          @courses.each do |course|
            (@s_Date..@e_Date).each do |date|
              @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            end
          end

        else #最新在庫は今日より過去
          render 'stock_new_first_month'
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
  def stock_edit_next_month
  end
  def stock_edit_next2_month
  end
  def stock_edit_next3_month
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
                                      activity_courses_attributes: [:id, :activity_id, :start_time, :_destroy,
                                        activity_stocks_attributes: [:id, :activity_id, :date,
                                        :activity_course_id, :stock, :season_price]],
                                      activity_ageprices_attributes: [:id, :activity_id, :age_from,
                                      :age_to, :normal_price, :high_price, :low_price, :_destroy])
    end

    def activity_stock_params
      params.require(:activity).permit(activity_courses_attributes: [:id, :activity_id,
                                       activity_stocks_attributes: [:id, :activity_id, :date,
                                       :course_id, :stock]])
    end


end
