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
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
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
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      if @activity.is_all_year_open
        #通年の体験
        @s_Date = Date.today.end_of_month + 1 #翌月1日
        @e_Date = @s_Date.end_of_month #翌月末
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
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
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
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
      @latest_stock_date = ActivityStock.where(activity_id: @activity.id).order(:date).last.date
      if @activity.is_all_year_open #　通年の体験
        if @latest_stock_date < Date.today # 今日以降の在庫がない
          render 'stock_new_first_month'
        elsif @latest_stock_date >= Date.today && @latest_stock_date < Date.today.end_of_month
          # 今日以降の在庫がない
          @exist_stock_s_Date = Date.today
          @exist_stock_e_Date = @latest_stock_date
          @s_Date = @latest_stock_date + 1
          @e_Date = Date.today.end_of_month
          @courses.each do |course|
            (@s_Date..@e_Date).each do |date|
              @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            end
          end
        else # 月末まで在庫ある
          @exist_stock_s_Date = Date.today
          @exist_stock_e_Date = Date.today.end_of_month
        end

      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date # 期間限定の体験
        if @activity.start_date <= Date.today # (1)開始日が今日以前
          if @latest_stock_date < Date.today # (1)-1 在庫が今日以降ない
            if @activity.end_date < Date.today

            elsif @activity.end_date >= Date.today && @activity.end_date >= Date.today.end_of_month

            else

            end
          elsif @latest_stock_date >= Date.today && @latest_stock_date < Date.today.end_of_month # (1)-2 在庫が今日以降〜月末までの間
            if @activity.end_date < Date.today

            elsif @activity.end_date >= Date.today && @activity.end_date <= @latest_stock_date

            elsif @activity.end_date > @latest_stock_date

            else

            end
          else # (1)-3 在庫が月末以降も存在
            if @activity.end_date < Date.today

            elsif @activity.end_date >= Date.today && @activity.end_date < Date.today.end_of_month

            else

            end
          end
        elsif @activity.start_date > Date.today && @activity.start_date <= Date.today.end_of_month #(2)開始日が今日以降 && 今月末より前
          if @latest_stock_date < @activity.start_date #在庫がstart日以降ない
            if @activity.end_date > Date.today.end_of_month

            else

            end
          elsif @latest_stock_date >= @activity.start_date && @latest_stock_date < Date.today.end_of_month # 在庫がstart以降あるが月末まではない
            if @activity.end_date <= @latest_stock_date

            elsif @activity.end_date > @latest_stock_date && @activity.end_date < Date.today.end_of_month

            else # 月末 <= end

            end
          else # 在庫がstartの翌月もある
            if @activity.end_date < Date.today.end_of_month

            else

            end
          end
        else @activity.start_date >= Date.today.end_of_month + 1 # 開始日が来月以降
          if @activity.start_date > @latest_stock_date
            if @activity.end_date < Date.today.end_of_month

            else

            end
          elsif @activity.start_date <= @latest_stock_date && @latest_stock_date < @activity.start_date.end_of_month
            if @activity.end_date <= @latest_stock_date

            elsif @activity.end_date > @latest_stock_date && @activity.end_date < @activity.start_date.end_of_month

            else

            end
          else # 在庫がstart月の翌月もある
            if @activity.end_date < Date.today.end_of_month

            else

            end
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



  def stock_edit_next_month
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      @latest_stock_date = ActivityStock.where(activity_id: @activity.id).order(:date).last.date
      if @activity.is_all_year_open #　通年の体験
      #   if @latest_stock_date <= Date.today.end_of_month # 来月分の在庫がない
      #     @s_Date = Date.today.end_of_month + 1
      #     @e_Date = (Date.today >> 1).end_of_month
      #   elsif @latest_stock_date > Date.today.end_of_month + 1 && @latest_stock_date < (Date.today >> 1).end_of_month # 在庫が来月の途中まで
      #     @exist_stock_s_Date = Date.today.end_of_month + 1
      #     @exist_stock_e_Date = @latest_stock_date
      #     @s_Date = @latest_stock_date + 1
      #     @e_Date = (Date.today >> 1).end_of_month
      #     @courses.each do |course|
      #       (@s_Date..@e_Date).each do |date|
      #         @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
      #       end
      #     end
      #   else # 来月末まで在庫ある
      #     @exist_stock_s_Date = Date.today.end_of_month + 1
      #     @exist_stock_e_Date = (Date.today >> 1).end_of_month
      #   end
      # elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date # 期間限定の体験
      #   if @latest_stock_date <= Date.today.end_of_month # 在庫が今月末以前
      #     if @activity.end_date <= #終了日が今月末以前
      #
      #     elsif @activity.end_date >= Date.today.end_of_month + 1 #終了日が来月頭より後ろ & 在庫より前
      #
      #     elsif #終了日が来月在庫より後ろ & 月末より前
      #
      #     else # 終了日が来月末以降
      #     end
      #   elsif @latest_stock_date > Date.today.end_of_month && @latest_stock_date < (Date.today >> 1).end_of_month　#在庫が来月頭より後ろ & 来月末より前
      #   else #在庫が来月末以降
      #   end


        # if @latest_stock_date >= (Date.today >> 1).end_of_month #来月分の在庫は作成済
        #   @s_Date = Date.today.end_of_month + 1
        #
        #   if @activity.end_date < (Date.today >> 1).end_of_month
        #     @e_Date = @activity.end_date
        #   else
        #     @e_Date = (Date.today >> 1).end_of_month
        #   end
        # elsif @latest_stock_date >= Date.today && @latest_stock_date < Date.today.end_of_month
        #   #在庫は来月のとある時点まで作成済み
        #
        #   if @activity.start_date > Date.today
        #     @exist_stock_s_Date = @activity.start_date
        #   else
        #     @exist_stock_s_Date = Date.today
        #   end
        #   @exist_stock_e_Date = @latest_stock_date
        #   @s_Date = @latest_stock_date + 1
        #   if @activity.end_date > (Date.today >> 1).end_of_month
        #     @e_Date = (Date.today >> 1).end_of_month
        #   else
        #     @e_Date = @activity.end_date
        #   end
        #   @courses.each do |course|
        #     (@s_Date..@e_Date).each do |date|
        #       @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
        #     end
        #   end

        # else #最新在庫は今日より過去
        #   @s_Date = Date.today.end_of_month + 1
        #   @e_Date = (Date.today >> 1).end_of_month
        #   @courses.each do |course|
        #     (@s_Date..@e_Date).each do |date|
        #       @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
        #     end
        #   end
        # end
      else
        flash[:alert] = '在庫を設定するには体験情報にて期間設定をしてください'
        redirect_to supplier_activities_path(current_supplier)
      end
    else
      flash[:alert] = '在庫を設定するには体験情報のコース時間または期間設定をしてください'
      redirect_to supplier_activities_path(current_supplier)
    end
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
