class ActivitiesController < ApplicationController
  def index
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activities = Activity.where(activity_business_id: @activity_business.id)
                          .order(created_at: :desc).page(params[:page]).per(10)
  end

  def drafts_activities
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activities = Activity.where(activity_business_id: @activity_business.id)
                          .where(status: 'draft').order(created_at: :desc).page(params[:page]).per(10)
  end

  def published_activities
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activities = Activity.where(activity_business_id: @activity_business.id)
                          .where(status: 'published')
                          .where(stop_now: false)
                          .order(created_at: :desc).page(params[:page]).per(10)
  end

  def deleted_activities
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activities = Activity.where(activity_business_id: @activity_business.id)
                          .where(status: 'deleted').order(created_at: :desc).page(params[:page]).per(10)
  end


  def show
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:id])
    if @activity.nil?
      redirect_to new_supplier_activity_path(current_supplier)
    else
      redirect_to edit_supplier_activity_path(current_supplier, @activity)
    end
  end

  def new
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = @activity_business.activities.build
    @activity.activity_translations.build
  end

  def create
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = @activity_business.activities.build(activity_params)
    if @activity.save
      flash[:notice] = '体験情報が作成されました'
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
    if @activity.town_id
      @town = @activity.town_id
    else
      @town = nil
    end
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update(activity_params)
        if params[:save_status] == '下書き保存'
          @activity.status = 'draft'
        else
          @activity.status = 'published'
        end
      @activity.save!

      if params[:activity][:this_page_path] == 'stock_edit_first_month' || params[:activity][:this_page_path] == 'stock_new_first_month'
        flash[:notice] = '在庫情報が保存されました'
        redirect_to supplier_activity_edit_stocks_first_month_path(current_supplier, @activity)
      elsif params[:activity][:this_page_path] == 'stock_edit_next_month'
        flash[:notice] = '在庫情報が保存されました'
        redirect_to supplier_activity_edit_stocks_next_month_path(current_supplier, @activity)
      elsif params[:activity][:this_page_path] == 'stock_edit_next2_month'
        flash[:notice] = '在庫情報が保存されました'
        redirect_to supplier_activity_edit_stocks_next2_month_path(current_supplier, @activity)
      elsif params[:activity][:this_page_path] == 'stock_edit_next3_month'
        flash[:notice] = '在庫情報が保存されました'
        redirect_to supplier_activity_edit_stocks_next3_month_path(current_supplier, @activity)
      else
        flash[:notice] = '体験情報が保存されました'
        redirect_to edit_supplier_activity_path(current_supplier, @activity)
      end
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

  def delete_activity
    @activity = Activity.find(params[:activity_id])
    if !@activity.nil?
      @activity.status = 'deleted'
      @activity.stop_now = true
      if @activity.save
        redirect_to supplier_activities_path(current_supplier)
      else
        flash[:alert] = '削除に失敗しました'
        redirect_to supplier_activities_path(current_supplier)
      end
    else
      flash[:alert] = 'まだ作成されていないため削除できません'
      redirect_to supplier_activities_path(current_supplier)
    end
  end

  def copy_activity
    @activity = Activity.find(params[:activity_id])
    @new_activity = @activity.dup
    @new_activity.name = "#{@activity.name}のコピー"
    # agepricesを複製
    ageprices = @activity.activity_ageprices
    ageprices.each do |ageprice|
      @new_activity.activity_ageprices.build(age_from: ageprice.age_from, age_to: ageprice.age_to,
                                            normal_price: ageprice.normal_price, high_price: ageprice.high_price,
                                            low_price: ageprice.low_price)
    end
    #coursesを複製
    course_times = @activity.activity_courses.pluck(:start_time)
    course_times.each do |course_time|
      @new_activity.activity_courses.build(start_time: course_time)
    end
    #translationを複製
    translations = @activity.activity_translations
    translations.each do |translation|
      @new_activity.activity_translations.build(language_id: translation.language_id, name: translation.name,
                                                profile_text: translation.profile_text, notes: translation.notes)
    end

    @new_activity.save!
    flash[:alert] = '体験を複製しました'
    redirect_to edit_supplier_activity_path(current_supplier, @new_activity)
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
      params.require(:activity).permit(:name, :description, :notes, :activity_business_id, :supplier_id,
                                      :activity_category_id, :main_image, :second_image,
                                      :third_image, :fourth_image,
                                      :remove_main_image, :remove_second_image, :remove_third_image, :remove_fourth_image,
                                      :prefecture_id, :area_id, :town_id,
                                      :detail_address, :longitude, :latitude,
                                      :meeting_spot1_japanese_address, :meeting_spot1_japanese_description,
                                      :meeting_spot1_longitude, :meeting_spot1_latitude,
                                      :activity_minutes, :has_season_price,
                                      :normal_adult_price, :high_adult_price, :low_adult_price,
                                      :normal_middle_price, :high_middle_price, :low_middle_price,
                                      :normal_kids_price, :high_kids_price, :low_kids_price,
                                      :maximum_num, :minimum_num, :available_age,  :is_all_year_open,
                                      :start_date, :end_date,
                                      :monday_open, :tuesday_open, :wednesday_open, :thursday_open,
                                      :friday_open, :saturday_open, :sunday_open,
                                      :january, :febrary, :march, :april, :may, :june, :july,
                                      :august, :september, :october, :november, :december,
                                      :advertise_activate, :is_approved, :stop_now, :status, :rain_or_shine,
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
