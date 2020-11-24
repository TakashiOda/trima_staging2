class TripManagersController < ApplicationController
  before_action :authenticate_user!, except: [:activity_detail]

  def home
    @project = Project.find(params[:project_id])
    # @areas = @project.areas
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    # @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    @user_projects = UserProject.where(project_id: @project.id)
    # @inviting_users = ProjectInvite.where(project_id: @project.id, has_account: 1)
  end

  def search_home
    @project = Project.find(params[:project_id])
    # @areas = @project.areas
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    # @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    @user_projects = UserProject.where(project_id: @project.id)
    # @inviting_users = ProjectInvite.where(project_id: @project.id, has_account: 1)
    @activities = Activity.all
  end

  def activity_detail
    @project = Project.find(params[:project_id])
    @activity = Activity.find(params[:activity_id])
    @ageprices = @activity.activity_ageprices
    if @activity.activity_courses.any?
      @courses = @activity.activity_courses
      if @courses[0].activity_stocks.any?
        # 今月の在庫を取得
        @this_month_stocks = []
        this_month_today = Date.today
        this_month_end = Date.today.end_of_month
        @courses[0].activity_stocks.each do |stock|
          if stock.date >= this_month_today && stock.date <= this_month_end
            @this_month_stocks.push(stock)
          end
        end
        # 来月の在庫を取得
        @next_month_stocks = []
        next_month_first = Date.today.next_month.beginning_of_month
        next_month_end = Date.today.next_month.end_of_month
        @courses[0].activity_stocks.each do |stock|
          if stock.date >= next_month_first && stock.date <= next_month_end
            @next_month_stocks.push(stock)
          end
        end

        # 再来月の在庫を取得
        @next2_month_stocks = []
        next2_month_first = (Date.today >> 2).beginning_of_month
        next2_month_end = (Date.today >> 2).end_of_month
        @courses[0].activity_stocks.each do |stock|
          if stock.date >= next2_month_first && stock.date <= next2_month_end
            @next2_month_stocks.push(stock)
          end
        end

        # 翌再来月の在庫を取得
        @next3_month_stocks = []
        next3_month_first = (Date.today >> 3).beginning_of_month
        next3_month_end = (Date.today >> 3).end_of_month
        @courses[0].activity_stocks.each do |stock|
          if stock.date >= next3_month_first && stock.date <= next3_month_end
            @next3_month_stocks.push(stock)
          end
        end

      end
    end
    @ageprice = @activity.activity_ageprices.order(:age_from).limit(1)[0]
    if @project.cart.nil?
      @cart = @project.build_cart
      @cart.save!
    else
      @cart = @project.cart
    end
    if current_user
      @book_activity = @cart.booked_activities.build(project_id: @project.id, activity_id: @activity.id, user_id: current_user.id)
    else
      @book_activity = @cart.booked_activities.build(project_id: @project.id, activity_id: @activity.id)
    end
  end

  def cart
    @project = Project.find(params[:project_id])
    if @project.cart.nil?
      @cart = @project.build_cart
      @cart.save!
    else
      @cart = @project.cart
      @booked_activities = @cart.booked_activities
    end

  end

  def experience_search
  end
end
