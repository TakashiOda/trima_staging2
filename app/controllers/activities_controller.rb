class ActivitiesController < ApplicationController
  def index
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activities = Activity.where(activity_business_id: @activity_business.id).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:id])
  end

  # PICTURE_COUNT = 3

  def new
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = @activity_business.activities.build
    @activity.activity_ageprices.build
    @activity.activity_translations.build
    # PICTURE_COUNT.times { @activity.activity_images.build }
  end

  def create
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = @activity_business.activities.build(activity_params)
    if @activity.save
      @activity.normal_adult_price = @activity.activity_ageprices[0].normal_price
      @activity.save!
      redirect_to supplier_activities_path(current_supplier)
    else
      render 'new'
    end
  end

  def edit
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:id])
    if @activity.activity_translations.find_by(language_id: 3).nil?
      @activity.activity_translations.build
    end
    # count = @activity.activity_images.count
    # (PICTURE_COUNT - count).times { @activity.activity_images.build }
  end

  def update
    # binding.pry
    @activity = Activity.find(params[:id])
    if @activity.update(activity_params)
      @activity.normal_adult_price = @activity.activity_ageprices[0].normal_price
      @activity.save!
      redirect_to supplier_activities_path(current_supplier)
    else
      render 'edit'
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    if @activity.destroy
      flash[:notice] = '体験コンテンツを削除しました'
      redirect_to supplier_activities_path(current_supplier)
    else
      flash[:alert] = '削除に失敗しました'
      render 'edit'
    end
  end


  def stock_new_first_month
    @activity = Activity.find(params[:activity_id])
    set_day_of_open_array(@activity)
    @courses = @activity.activity_courses
    if !@courses.blank?
      if @activity.is_all_year_open #通年の体験
        #当月分の在庫 new
        @s_Date = Date.today #体験の開始日
        @e_Date = Date.today.end_of_month #当月の末日
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: 0)
          end
        end
      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date #期間限定の体験
        if @activity.start_date > Date.today
          @s_Date = @activity.start_date # start_dateが来月の場合もある
        else
          @s_Date = Date.today # start_dateが来月の場合もある
        end
        if @activity.end_date < @activity.start_date.end_of_month
          @e_Date = @activity.end_date
        else
          @e_Date = @activity.start_date.end_of_month #end_dateが月末より前の可能性がある
        end
        @courses.each do |course|
          (@s_Date..@e_Date).each do |date|
            @stock = course.activity_stocks.build(date: date, stock: 0)
          end
        end
      else
        redirect_to_index_because_of_no_term
      end
      if !@s_Date.nil? && !@e_Date.nil?
        @dates = setDates(@s_Date, @e_Date)
      end
    else
      redirect_to_index_because_of_no_term_or_no_courses
    end
  end

  def stock_new_next_month
    @activity = Activity.find(params[:activity_id])
    set_day_of_open_array(@activity)
    set_dates_for_stock_new_all_year_and_limit_term_activity(action_name, @activity)
  end

  def stock_new_next2_month
    @activity = Activity.find(params[:activity_id])
    set_day_of_open_array(@activity)
    set_dates_for_stock_new_all_year_and_limit_term_activity(action_name, @activity)
  end

  def stock_new_next3_month
    @activity = Activity.find(params[:activity_id])
    set_day_of_open_array(@activity)
    set_dates_for_stock_new_all_year_and_limit_term_activity(action_name, @activity)
  end


  def stock_edit_first_month
    @activity = Activity.find(params[:activity_id])
    @courses = @activity.activity_courses
    if !@courses.blank?
      @latest_stock_date = ActivityStock.where(activity_course_id: @activity.activity_courses.first.id).order(:date).last.date
      if @activity.is_all_year_open #　通年の体験
        set_all_year_activity_dates(action_name, @latest_stock_date)
      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date # 期間限定の体験
        if @activity.end_date > Date.today
          if @activity.start_date <= Date.today # (1)開始日が今日以前
            if @latest_stock_date < Date.today # (1)-1 在庫が今日以降ない
              if @activity.end_date >= Date.today && @activity.end_date >= Date.today.end_of_month
                @s_Date = Date.today
                @e_Date = @activity.end_date
              else
                @s_Date = Date.today
                @e_Date = Date.today.end_of_month
              end

            elsif @latest_stock_date >= Date.today && @latest_stock_date < Date.today.end_of_month # (1)-2 在庫が今日以降〜月末までの間
              if @activity.end_date >= Date.today && @activity.end_date <= @latest_stock_date
                @exist_stock_s_Date = Date.today
                @exist_stock_e_Date = @activity.end_date
              elsif @activity.end_date > @latest_stock_date
                @exist_stock_s_Date = Date.today
                @exist_stock_e_Date = @latest_stock_date
                @s_Date = @latest_stock_date + 1
                @e_Date = @activity.end_date
              elsif @activity.end_date > Date.today.end_of_month
                @exist_stock_s_Date = Date.today
                @exist_stock_e_Date = @latest_stock_date
                @s_Date = @latest_stock_date + 1
                @e_Date = Date.today.end_of_month
              end

            else # (1)-3 在庫が月末以降も存在
              if @activity.end_date >= Date.today && @activity.end_date < Date.today.end_of_month
                @exist_stock_s_Date = Date.today
                @exist_stock_e_Date = @activity.end_date
              else
                @exist_stock_s_Date = Date.today
                @exist_stock_e_Date = Date.today.end_of_month
              end
            end
          elsif @activity.start_date > Date.today && @activity.start_date <= Date.today.end_of_month #(2)開始日が今日以降 && 今月末より前
            if @latest_stock_date < @activity.start_date #在庫がstart日以降ない
              if @activity.end_date < Date.today.end_of_month
                @s_Date = @activity.start_date
                @e_Date = @activity.end_date
              else
                @s_Date = @activity.start_date
                @e_Date = Date.today.end_of_month
              end
            elsif @latest_stock_date >= @activity.start_date && @latest_stock_date < Date.today.end_of_month # 在庫がstart以降あるが月末まではない
              if @activity.end_date <= @latest_stock_date
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @activity.end_date
              elsif @activity.end_date > @latest_stock_date && @activity.end_date < Date.today.end_of_month
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @latest_stock_date
                @s_Date = @latest_stock_date + 1
                @e_Date = @activity.end_date
              else # 月末 <= end
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @latest_stock_date
                @s_Date = @latest_stock_date + 1
                @e_Date = Date.today.end_of_month
              end
            else # 在庫がstartの翌月もある
              if @activity.end_date < Date.today.end_of_month
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @activity.end_date
              else
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = Date.today.end_of_month
              end
            end
          else @activity.start_date >= Date.today.end_of_month + 1 # 開始日が来月以降
            if @activity.start_date > @latest_stock_date
              if @activity.end_date < @activity.start_date.end_of_month
                @s_Date = @activity.start_date
                @e_Date = @activity.end_date
              else
                @s_Date = @activity.start_date
                @e_Date = @activity.start_date.end_of_month
              end
            elsif @activity.start_date <= @latest_stock_date && @latest_stock_date < @activity.start_date.end_of_month
              if @activity.end_date <= @latest_stock_date
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @activity.end_date
              elsif @activity.end_date > @latest_stock_date && @activity.end_date < @activity.start_date.end_of_month
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @latest_stock_date
                @s_Date = @latest_stock_date + 1
                @e_Date = @activity.end_date
              else
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @latest_stock_date
                @s_Date = @latest_stock_date + 1
                @e_Date = @activity.start_date.end_of_month
              end
            else # 在庫がstart月の翌月もある
              if @activity.end_date < Date.today.end_of_month
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @activity.end_date
              else
                @exist_stock_s_Date = @activity.start_date
                @exist_stock_e_Date = @activity.start_date.end_of_month
              end
            end
          end
        else
          redirect_to_index_because_of_out_of_expiration
        end
      else
        redirect_to_index_because_of_no_term
      end
      if !@s_Date.nil? && !@e_Date.nil?
        @dates = setDates(@s_Date, @e_Date)
      end
      if !@exist_stock_s_Date.nil? && !@exist_stock_e_Date.nil?
        @exist_stock_dates = setDates(@exist_stock_s_Date, @exist_stock_e_Date)
      end
    else
      redirect_to_index_because_of_no_term_or_no_courses
    end
  end


  def stock_edit_next_month
    @activity = Activity.find(params[:activity_id])
    set_dates_all_year_and_limit_term_activity(@activity)
  end


  def stock_edit_next2_month
    @activity = Activity.find(params[:activity_id])
    set_dates_all_year_and_limit_term_activity(@activity)
  end


  def stock_edit_next3_month
    @activity = Activity.find(params[:activity_id])
    set_dates_all_year_and_limit_term_activity(@activity)
  end

  private
    def activity_params
      params.require(:activity).permit(:name, :description, :notes, :activity_business_id,
                                      :activity_category_id, :main_image, :second_image,
                                      :third_image, :fourth_image,
                                      :remove_main_image, :remove_second_image, :remove_third_image, :remove_fourth_image,
                                      :prefecture_id, :area_id, :town_id,
                                      :detail_address, :longitude, :latitude,
                                      :activity_minutes,
                                      :normal_adult_price, :has_season_price,
                                      :maximum_num, :minimum_num, :available_age,  :is_all_year_open,
                                      :start_date, :end_date,
                                      :monday_open, :tuesday_open, :wednesday_open, :thursday_open,
                                      :friday_open, :saturday_open, :sunday_open,
                                      :january, :febrary, :march, :april,
                                      :may, :june, :july, :august, :september, :october,
                                      :november, :december, :advertise_activate, :is_approved, :stop_now,
                                      activity_courses_attributes: [:id, :activity_id, :start_time, :_destroy,
                                        activity_stocks_attributes: [:id, :activity_id, :date,
                                        :activity_course_id, :stock, :season_price]],
                                      activity_ageprices_attributes: [:id, :activity_id, :age_from,
                                      :age_to, :normal_price, :high_price, :low_price, :_destroy],
                                      activity_translations_attributes: [:id, :activity_id, :language_id,
                                      :name, :profile_text, :notes])
    end

    def activity_stock_params
      params.require(:activity).permit(activity_courses_attributes: [:id, :activity_id,
                                       activity_stocks_attributes: [:id, :activity_id, :date,
                                       :course_id, :stock]])
    end

    def set_all_year_activity_dates(action_name, latest_stock_date)
      # 共通処理
      case action_name
      when 'stock_edit_next_month'
        end_of_last_month = Date.today.end_of_month
        end_of_this_month = (Date.today >> 1).end_of_month
      when 'stock_edit_next2_month'
        end_of_last_month = (Date.today >> 1).end_of_month
        end_of_this_month = (Date.today >> 2).end_of_month
      when 'stock_edit_next3_month'
        end_of_last_month = (Date.today >> 2).end_of_month
        end_of_this_month = (Date.today >> 3).end_of_month
      end

      if action_name == 'stock_edit_first_month'
        if latest_stock_date < Date.today # 今日以降の在庫がない
          render 'stock_new_first_month'
        elsif latest_stock_date >= Date.today && latest_stock_date < Date.today.end_of_month
          @exist_stock_s_Date = Date.today
          @exist_stock_e_Date = latest_stock_date
          @s_Date = latest_stock_date + 1
          @e_Date = Date.today.end_of_month
        else
          @exist_stock_s_Date = Date.today
          @exist_stock_e_Date = Date.today.end_of_month
        end
      else
        if latest_stock_date <= end_of_last_month
          @s_Date = end_of_last_month + 1
          @e_Date = end_of_this_month
        elsif latest_stock_date > end_of_last_month && latest_stock_date < end_of_this_month
          @exist_stock_s_Date = end_of_last_month + 1
          @exist_stock_e_Date = latest_stock_date
          @s_Date = latest_stock_date + 1
          @e_Date = end_of_this_month
        else
          @exist_stock_s_Date = end_of_last_month + 1
          @exist_stock_e_Date = end_of_this_month
        end
      end
    end

    def set_limit_term_activity_dates(action_name, activity, latest_stock_date)
      case action_name
      when 'stock_edit_next_month'
        end_of_last_month = Date.today.end_of_month
        end_of_this_month = (Date.today >> 1).end_of_month
        end_of_last_month_from_start_date = activity.start_date.end_of_month
        end_of_this_month_from_start_date = (activity.start_date >> 1).end_of_month
      when 'stock_edit_next2_month'
        end_of_last_month = (Date.today >> 1).end_of_month
        end_of_this_month = (Date.today >> 2).end_of_month
        end_of_last_month_from_start_date = (activity.start_date >> 1).end_of_month
        end_of_this_month_from_start_date = (activity.start_date >> 2).end_of_month
      when 'stock_edit_next3_month'
        end_of_last_month = (Date.today >> 2).end_of_month
        end_of_this_month = (Date.today >> 3).end_of_month
        end_of_last_month_from_start_date = (activity.start_date >> 2).end_of_month
        end_of_this_month_from_start_date = (activity.start_date >> 3).end_of_month
      end

      if activity.end_date > end_of_last_month || activity.end_date > end_of_last_month_from_start_date
        if activity.start_date < Date.today.end_of_month
          if latest_stock_date <= end_of_last_month # 在庫が翌月分ない
            if activity.end_date > end_of_last_month && activity.end_date < end_of_this_month
              @s_Date = end_of_last_month + 1
              @e_Date = activity.end_date
            else
              @s_Date = end_of_last_month + 1
              @e_Date = end_of_this_month
            end
          elsif latest_stock_date > end_of_last_month && latest_stock_date < end_of_this_month # 在庫が途中まである
            if activity.end_date > end_of_last_month && activity.end_date <= latest_stock_date
              @exist_stock_s_Date = end_of_last_month + 1
              @exist_stock_e_Date = activity.end_date
            elsif activity.end_date > latest_stock_date && activity.end_date < end_of_this_month
              @exist_stock_s_Date = end_of_last_month + 1
              @exist_stock_e_Date = latest_stock_date
              @s_Date = latest_stock_date + 1
              @e_Date = activity.end_date
            else
              @exist_stock_s_Date = end_of_last_month + 1
              @exist_stock_e_Date = latest_stock_date
              @s_Date = latest_stock_date + 1
              @e_Date = end_of_this_month
            end
          else
            if activity.end_date > end_of_last_month && activity.end_date < end_of_this_month
              @exist_stock_s_Date = end_of_last_month + 1
              @exist_stock_e_Date = activity.end_date
            else
              @exist_stock_s_Date = end_of_last_month + 1
              @exist_stock_e_Date = end_of_this_month
            end
          end
        else #当月はstart月
          if latest_stock_date <= end_of_last_month_from_start_date
            if activity.end_date > end_of_last_month_from_start_date && activity.end_date < (@activity.start_date >> 3).end_of_month
              @s_Date = end_of_last_month_from_start_date + 1
              @e_Date = activity.end_date
            else
              @s_Date = end_of_last_month_from_start_date + 1
              @e_Date = end_of_this_month_from_start_date
            end
          elsif latest_stock_date > end_of_last_month_from_start_date && latest_stock_date < end_of_this_month_from_start_date
            if activity.end_date > end_of_last_month_from_start_date && activity.end_date <= latest_stock_date
              @exist_stock_s_Date = end_of_last_month_from_start_date + 1
              @exist_stock_e_Date = activity.end_date
            elsif activity.end_date > latest_stock_date && activity.end_date < end_of_this_month_from_start_date
              @exist_stock_s_Date = end_of_last_month_from_start_date + 1
              @exist_stock_e_Date = latest_stock_date
              @s_Date = latest_stock_date + 1
              @e_Date = activity.end_date
            else
              @exist_stock_s_Date = end_of_last_month_from_start_date + 1
              @exist_stock_e_Date = latest_stock_date
              @s_Date = latest_stock_date + 1
              @e_Date = end_of_this_month_from_start_date
            end
          else
            if activity.end_date > end_of_last_month_from_start_date && activity.end_date < end_of_this_month_from_start_date
              @exist_stock_s_Date = end_of_last_month_from_start_date + 1
              @exist_stock_e_Date = activity.end_date
            else
              @exist_stock_s_Date = end_of_last_month_from_start_date + 1
              @exist_stock_e_Date = end_of_this_month_from_start_date
            end
          end
        end
      else
        # 体験が終了している時の処理
        redirect_to_index_because_of_out_of_expiration
      end
    end

    def setDates(startDate, endDate)
      dateArray = []
      (startDate..endDate).each do |date|
        dateArray.push(date)
      end
      return dateArray
    end

    def set_day_of_open_array(activity)
      # 最終的にactivityのモデルメソッドに
      @days_of_open = []
      if activity.sunday_open
        @days_of_open.push(0)
      end
      if activity.monday_open
        @days_of_open.push(1)
      end
      if activity.tuesday_open
        @days_of_open.push(2)
      end
      if activity.wednesday_open
        @days_of_open.push(3)
      end
      if activity.thursday_open
        @days_of_open.push(4)
      end
      if activity.friday_open
        @days_of_open.push(5)
      end
      if activity.saturday_open
        @days_of_open.push(6)
      end
    end

    def redirect_to_index_because_of_no_term
      flash[:alert] = '在庫を設定するには体験情報にて期間設定をしてください'
      redirect_to supplier_activities_path(current_supplier)
    end

    def redirect_to_index_because_of_out_of_expiration
      flash[:alert] = '体験期間が終了しています。期間を再設定してください'
      redirect_to supplier_activities_path(current_supplier)
    end

    def redirect_to_index_because_of_no_term_or_no_courses
      flash[:alert] = '在庫を設定するには体験情報のコース時間または期間設定をしてください'
      redirect_to supplier_activities_path(current_supplier)
    end

    def set_dates_for_stock_new_all_year_and_limit_term_activity(action_name, activity)
      if activity.is_all_year_open
        case action_name
        when 'stock_new_next_month'
          end_of_last_month = Date.today.end_of_month
          # end_of_last_month_from_start_date =
          # end_of_this_month_from_start_date = (activity.start_date >> 1).end_of_month
        when 'stock_new_next2_month'
          end_of_last_month = (Date.today >> 1).end_of_month
          # end_of_last_month_from_start_date = (activity.start_date >> 1).end_of_month
          # end_of_this_month_from_start_date = (activity.start_date >> 2).end_of_month
        when 'stock_new_next3_month'
          end_of_last_month = (Date.today >> 2).end_of_month
          # end_of_last_month_from_start_date = (activity.start_date >> 2).end_of_month
          # end_of_this_month_from_start_date = (activity.start_date >> 3).end_of_month
        end
      else
        case action_name
        when 'stock_new_next_month'
          end_of_last_month = Date.today.end_of_month
          end_of_last_month_from_start_date = activity.start_date.end_of_month
          end_of_this_month_from_start_date = (activity.start_date >> 1).end_of_month
        when 'stock_new_next2_month'

          end_of_last_month = (Date.today >> 1).end_of_month
          end_of_last_month_from_start_date = (activity.start_date >> 1).end_of_month
          end_of_this_month_from_start_date = (activity.start_date >> 2).end_of_month
        when 'stock_new_next3_month'
          end_of_last_month = (Date.today >> 2).end_of_month
          end_of_last_month_from_start_date = (activity.start_date >> 2).end_of_month
          end_of_this_month_from_start_date = (activity.start_date >> 3).end_of_month
        end
      end

      @courses = activity.activity_courses

      if !@courses.blank?
        if activity.is_all_year_open #通年の体験
          @s_Date = end_of_last_month + 1
          @e_Date = @s_Date.end_of_month
          @courses.each do |course|
            (@s_Date..@e_Date).each do |date|
              @stock = course.activity_stocks.build(date: date, stock: 0)
            end
          end
        elsif !activity.is_all_year_open && activity.start_date && activity.end_date #期間限定の体験
          @s_Date = end_of_last_month_from_start_date + 1 # start_dateが来月の場合もある
          if activity.end_date <= end_of_this_month_from_start_date
            @e_Date = activity.end_date
          else
            @e_Date = end_of_this_month_from_start_date #end_dateが月末より前の可能性がある
          end
          @courses.each do |course|
            (@s_Date..@e_Date).each do |date|
              @stock = course.activity_stocks.build(date: date, stock: 0)
            end
          end
        else
          redirect_to_index_because_of_no_term
        end
        if !@s_Date.nil? && !@e_Date.nil?
          @dates = setDates(@s_Date, @e_Date)
        end
      else
        redirect_to_index_because_of_no_term_or_no_courses
      end
    end

    def set_dates_all_year_and_limit_term_activity(activity)
      @courses = activity.activity_courses
      if !@courses.blank?
        @latest_stock_date = ActivityStock.where(activity_course_id: activity.activity_courses.first.id).order(:date).last.date
        if activity.is_all_year_open #　通年の体験
          set_all_year_activity_dates(action_name, @latest_stock_date)
        elsif !activity.is_all_year_open && activity.start_date && activity.end_date # 期間限定の体験
          set_limit_term_activity_dates(action_name, activity, @latest_stock_date)
        else
          redirect_to_index_because_of_no_term
        end
        if !@s_Date.nil? && !@e_Date.nil?
          @dates = setDates(@s_Date, @e_Date)
        end
        if !@exist_stock_s_Date.nil? && !@exist_stock_e_Date.nil?
          @exist_stock_dates = setDates(@exist_stock_s_Date, @exist_stock_e_Date)
        end
      else
        redirect_to_index_because_of_no_term_or_no_courses
      end
    end
end
