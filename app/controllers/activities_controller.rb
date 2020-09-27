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
        @dates = []
        (@s_Date..@e_Date).each do |date|
          @dates.push(date)
        end


      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date
        #期間限定の体験
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
        @dates = []
        (@s_Date..@e_Date).each do |date|
          @dates.push(date)
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
        @dates = []
        (@s_Date..@e_Date).each do |date|
          @dates.push(date)
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
        @dates = []
        (@s_Date..@e_Date).each do |date|
          @dates.push(date)
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
        @dates = []
        (@s_Date..@e_Date).each do |date|
          @dates.push(date)
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
        @dates = []
        (@s_Date..@e_Date).each do |date|
          @dates.push(date)
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
        @dates = []
        (@s_Date..@e_Date).each do |date|
          @dates.push(date)
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
        @dates = []
        (@s_Date..@e_Date).each do |date|
          @dates.push(date)
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
      @latest_stock_date = ActivityStock.where(activity_course_id: @activity.activity_courses.first.id).order(:date).last.date
      if @activity.is_all_year_open #　通年の体験
        if @latest_stock_date < Date.today # 今日以降の在庫がない
          render 'stock_new_first_month'
        elsif @latest_stock_date >= Date.today && @latest_stock_date < Date.today.end_of_month
          # 今日以降の在庫がある
          @exist_stock_s_Date = Date.today
          @exist_stock_e_Date = @latest_stock_date
          @s_Date = @latest_stock_date + 1
          @e_Date = Date.today.end_of_month
          @courses.each do |course|
            (@s_Date..@e_Date).each do |date|
              @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            end
          end
          @exist_stock_dates = []
          (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
            @exist_stock_dates.push(exist_date)
          end
          @dates = []
          (@s_Date..@e_Date).each do |date|
            @dates.push(date)
          end
        else # 月末まで在庫ある
          @exist_stock_s_Date = Date.today
          @exist_stock_e_Date = Date.today.end_of_month
          @exist_stock_dates = []
          (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
            @exist_stock_dates.push(exist_date)
          end
        end

      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date # 期間限定の体験
        if @activity.start_date <= Date.today # (1)開始日が今日以前
          if @latest_stock_date < Date.today # (1)-1 在庫が今日以降ない
            if @activity.end_date < Date.today
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date >= Date.today && @activity.end_date >= Date.today.end_of_month
              @s_Date = Date.today
              @e_Date = @activity.end_date
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
            else
              @s_Date = Date.today
              @e_Date = Date.today.end_of_month
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
            end

          elsif @latest_stock_date >= Date.today && @latest_stock_date < Date.today.end_of_month # (1)-2 在庫が今日以降〜月末までの間
            if @activity.end_date < Date.today
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date >= Date.today && @activity.end_date <= @latest_stock_date
              @exist_stock_s_Date = Date.today
              @exist_stock_e_Date = @activity.end_date
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            elsif @activity.end_date > @latest_stock_date
              @exist_stock_s_Date = Date.today
              @exist_stock_e_Date = @latest_stock_date
              @s_Date = @latest_stock_date + 1
              @e_Date = @activity.end_date
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            elsif @activity.end_date > Date.today.end_of_month
              @exist_stock_s_Date = Date.today
              @exist_stock_e_Date = @latest_stock_date
              @s_Date = @latest_stock_date + 1
              @e_Date = Date.today.end_of_month
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            end

          else # (1)-3 在庫が月末以降も存在
            if @activity.end_date < Date.today
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date >= Date.today && @activity.end_date < Date.today.end_of_month
              @exist_stock_s_Date = Date.today
              @exist_stock_e_Date = @activity.end_date
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            else
              @exist_stock_s_Date = Date.today
              @exist_stock_e_Date = Date.today.end_of_month
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            end
          end
        elsif @activity.start_date > Date.today && @activity.start_date <= Date.today.end_of_month #(2)開始日が今日以降 && 今月末より前
          if @latest_stock_date < @activity.start_date #在庫がstart日以降ない
            if @activity.end_date > Date.today.end_of_month
              @s_Date = @activity.start_date
              @e_Date = @activity.start_date
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
            else
              @s_Date = @activity.start_date
              @e_Date = Date.today.end_of_month
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
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
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
            else # 月末 <= end
              @exist_stock_s_Date = @activity.start_date
              @exist_stock_e_Date = @latest_stock_date
              @s_Date = @latest_stock_date + 1
              @e_Date = Date.today.end_of_month
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
            end
            @exist_stock_dates = []
            (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
              @exist_stock_dates.push(exist_date)
            end
          else # 在庫がstartの翌月もある
            if @activity.end_date < Date.today.end_of_month
              @exist_stock_s_Date = @activity.start_date
              @exist_stock_e_Date = @activity.end_date
            else
              @exist_stock_s_Date = @activity.start_date
              @exist_stock_e_Date = Date.today.end_of_month
            end
            @exist_stock_dates = []
            (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
              @exist_stock_dates.push(exist_date)
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
            @dates = []
            (@s_Date..@e_Date).each do |date|
              @dates.push(date)
            end
            @courses.each do |course|
              (@s_Date..@e_Date).each do |date|
                @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
              end
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
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
            else
              @exist_stock_s_Date = @activity.start_date
              @exist_stock_e_Date = @latest_stock_date
              @s_Date = @latest_stock_date + 1
              @e_Date = @activity.start_date.end_of_month
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
            end
            @exist_stock_dates = []
            (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
              @exist_stock_dates.push(exist_date)
            end
          else # 在庫がstart月の翌月もある
            if @activity.end_date < Date.today.end_of_month
              @exist_stock_s_Date = @activity.start_date
              @exist_stock_e_Date = @activity.end_date
            else
              @exist_stock_s_Date = @activity.start_date
              @exist_stock_e_Date = @activity.start_date.end_of_month
            end
            @exist_stock_dates = []
            (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
              @exist_stock_dates.push(exist_date)
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
      @latest_stock_date = ActivityStock.where(activity_course_id: @activity.activity_courses.first.id).order(:date).last.date
      if @activity.is_all_year_open #　通年の体験
        if @latest_stock_date <= Date.today.end_of_month
          @s_Date = Date.today.end_of_month + 1
          @e_Date = (Date.today >> 1).end_of_month
          @courses.each do |course|
            (@s_Date..@e_Date).each do |date|
              @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            end
          end
          @dates = []
          (@s_Date..@e_Date).each do |date|
            @dates.push(date)
          end
        elsif @latest_stock_date > Date.today.end_of_month && @latest_stock_date < (Date.today >> 1).end_of_month # 在庫は翌月頭〜翌月末までの間
          @exist_stock_s_Date = Date.today.end_of_month + 1
          @exist_stock_e_Date = @latest_stock_date
          @s_Date = @latest_stock_date + 1
          @e_Date = (Date.today >> 1).end_of_month
          @exist_stock_dates = []
          (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
            @exist_stock_dates.push(exist_date)
          end
          @courses.each do |course|
            (@s_Date..@e_Date).each do |date|
              @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
            end
          end
          @dates = []
          (@s_Date..@e_Date).each do |date|
            @dates.push(date)
          end
        end

      elsif !@activity.is_all_year_open && @activity.start_date && @activity.end_date # 期間限定の体験
        if @activity.start_date < Date.today.end_of_month #翌月 = 今日の翌月
          if @latest_stock_date <= Date.today.end_of_month # 在庫が翌月分ない
            if @activity.end_date <= Date.today.end_of_month
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date > Date.today.end_of_month && @activity.end_date < (Date.today >> 1).end_of_month
              @s_Date = Date.today.end_of_month + 1
              @e_Date = @activity.end_date
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end

            else
              @s_Date = Date.today.end_of_month + 1
              @e_Date = (Date.today >> 1).end_of_month
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
            end

          elsif @latest_stock_date > Date.today.end_of_month && @latest_stock_date < (Date.today >> 1).end_of_month　# 在庫が途中まである
            if @activity.end_date <= Date.today.end_of_month
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date > Date.today.end_of_month && @activity.end_date <= @latest_stock_date
              @exist_stock_s_Date = Date.today.end_of_month + 1
              @exist_stock_e_Date = @activity.end_date
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            elsif @activity.end_date > @latest_stock_date && @activity.end_date < (Date.today >> 1).end_of_month
              @exist_stock_s_Date = Date.today.end_of_month + 1
              @exist_stock_e_Date = @latest_stock_date
              @s_Date = @latest_stock_date + 1
              @e_Date = @activity.end_date
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
            else
              @exist_stock_s_Date = Date.today.end_of_month + 1
              @exist_stock_e_Date = @latest_stock_date
              @s_Date = @latest_stock_date + 1
              @e_Date = (Date.today >> 1).end_of_month
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
            end
          else
            if @activity.end_date <= Date.today.end_of_month
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date > Date.today.end_of_month && @activity.end_date < (Date.today >> 1).end_of_month
              @exist_stock_s_Date = Date.today.end_of_month + 1
              @exist_stock_e_Date = @activity.end_date
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            else
              @exist_stock_s_Date = Date.today.end_of_month + 1
              @exist_stock_e_Date = (Date.today >> 1).end_of_month
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            end
          end
        else # 翌月 = start日の翌月
          if @latest_stock_date <= @activity.start_date.end_of_month
            if @activity.end_date <= @activity.start_date.end_of_month
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date > @activity.start_date.end_of_month && @activity.end_date < (@activity.start_date >> 1).end_of_month
              @s_Date = @activity.start_date.end_of_month + 1
              @e_Date = @activity.end_date
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
            else
              @s_Date = @activity.start_date.end_of_month + 1
              @e_Date = (@activity.start_date >> 1).end_of_month
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
            end
          elsif @latest_stock_date > @activity.start_date.end_of_month && @latest_stock_date < (@activity.start_date >> 1).end_of_month
            if @activity.end_date <= @activity.start_date.end_of_month
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date > @activity.start_date.end_of_month && @activity.end_date <= @latest_stock_date
              @exist_stock_s_Date = @activity.start_date.end_of_month + 1
              @exist_stock_e_Date = @activity.end_date
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            elsif @activity.end_date > @latest_stock_date && @activity.end_date < (@activity.start_date >> 1).end_of_month
              @exist_stock_s_Date = @activity.start_date.end_of_month + 1
              @exist_stock_e_Date = @latest_stock_date
              @s_Date = @latest_stock_date + 1
              @e_Date = @activity.end_date
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
            else
              @exist_stock_s_Date = @activity.start_date.end_of_month + 1
              @exist_stock_e_Date = @latest_stock_date
              @s_Date = @latest_stock_date + 1
              @e_Date = (@activity.start_date >> 1).end_of_month
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
              @courses.each do |course|
                (@s_Date..@e_Date).each do |date|
                  @stock = course.activity_stocks.build(date: date, stock: @activity.maximum_num)
                end
              end
              @dates = []
              (@s_Date..@e_Date).each do |date|
                @dates.push(date)
              end
            end
          else
            if @activity.end_date <= @activity.start_date.end_of_month
              flash[:alert] = '体験期間が終了しています。期間を再設定してください'
              redirect_to supplier_activities_path(current_supplier)
            elsif @activity.end_date > @activity.start_date.end_of_month && @activity.end_date < (@activity.start_date >> 1).end_of_month
              @exist_stock_s_Date = @activity.start_date.end_of_month + 1
              @exist_stock_e_Date = @activity.end_date
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
            else
              @exist_stock_s_Date = @activity.start_date.end_of_month + 1
              @exist_stock_e_Date = (@activity.start_date >> 1).end_of_month
              @exist_stock_dates = []
              (@exist_stock_s_Date..@exist_stock_e_Date).each do |exist_date|
                @exist_stock_dates.push(exist_date)
              end
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
