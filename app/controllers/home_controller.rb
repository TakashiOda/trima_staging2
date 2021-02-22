class HomeController < ApplicationController
  def index
    # @top_activity = Activity.find(20)
    @activities = Activity.all.where(is_approved: true).order(created_at: :desc).limit(12)
    # @activities =  Activity.includes(activity_courses: :activity_stocks).references(:activity_courses).where("activity_courses.id IS NOT NULL")
    # @activities =  Activity.left_joins(:activity_courses).select("activity_courses.*").where("activity_courses.id is null")
    @categories = ActivityCategory.all.limit(15)
  end

  def activity_show
    @activity = Activity.find(params[:activity_id])
    @supplier = Supplier.find(@activity.supplier_id)
    @activity_business = ActivityBusiness.find(@activity.activity_business_id)
    @holidays = [@activity.monday_open, @activity.tuesday_open, @activity.wednesday_open, @activity.thursday_open,
                 @activity.friday_open, @activity.saturday_open, @activity.sunday_open]
    if @activity.activity_courses.any?
      @courses = @activity.activity_courses
      if @courses[0].activity_stocks.any?
        # 今月の在庫を取得
        @this_month_stocks = []
        this_month_today = Date.tomorrow
        this_month_end = Date.tomorrow.end_of_month
        @courses[0].activity_stocks.each do |stock|
          if stock.date >= this_month_today && stock.date <= this_month_end
            @this_month_stocks.push(stock)
          end
        end
        # 来月の在庫を取得
        @next_month_stocks = []
        next_month_first = Date.tomorrow.next_month.beginning_of_month
        next_month_end = Date.tomorrow.next_month.end_of_month
        @courses[0].activity_stocks.each do |stock|
          if stock.date >= next_month_first && stock.date <= next_month_end
            @next_month_stocks.push(stock)
          end
        end

        # 再来月の在庫を取得
        @next2_month_stocks = []
        next2_month_first = (Date.tomorrow >> 2).beginning_of_month
        next2_month_end = (Date.tomorrow >> 2).end_of_month
        @courses[0].activity_stocks.each do |stock|
          if stock.date >= next2_month_first && stock.date <= next2_month_end
            @next2_month_stocks.push(stock)
          end
        end

        # 翌再来月の在庫を取得
        @next3_month_stocks = []
        next3_month_first = (Date.tomorrow >> 3).beginning_of_month
        next3_month_end = (Date.tomorrow >> 3).end_of_month
        @courses[0].activity_stocks.each do |stock|
          if stock.date >= next3_month_first && stock.date <= next3_month_end
            @next3_month_stocks.push(stock)
          end
        end

      end
    else
      @courses = nil
    end
  end

  def about_page_for_user
  end

end
