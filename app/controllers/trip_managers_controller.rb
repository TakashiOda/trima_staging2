class TripManagersController < ApplicationController
  before_action :authenticate_user!, except: [:activity_detail]

  def members_new
    @project = Project.find(params[:project_id])
    @member = @project.project_members.build
  end

  def members_create
    @project = Project.find(params[:project_id])
    @member = @project.project_members.create(member_params)
    if @member.persisted?
      redirect_to project_members_path(@project)
    else
      render 'members_new'
    end
  end

  def members_edit
    @project = Project.find(params[:project_id])
    @member = ProjectMember.find_by(id: params[:id])
  end

  def members_update
    @project = Project.find(params[:project_id])
    @member = ProjectMember.find(params[:id])
    if @member.update(member_params)
      redirect_to project_members_path(@project)
    else
      render 'member_edit'
    end
  end

  def home
    @project = Project.find(params[:project_id])
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    @user_projects = UserProject.where(project_id: @project.id)
  end
  def search_home
    @project = Project.find(params[:project_id])
    @owner = User.find(UserProject.find_by(project_id: params[:project_id], control_level: 0).user_id)
    @user_projects = UserProject.where(project_id: @project.id)
    @activities = Activity.joins(:activity_courses).where("activity_courses.id IS NOT NULL").distinct
  end

  def activity_detail
    @project = Project.find(params[:project_id])
    @current_user = current_user
    @activity = Activity.find(params[:activity_id])
    @supplier = Supplier.find(@activity.supplier_id)
    @ageprices = @activity.activity_ageprices.order(age_from: :desc)
    @ageprices_json = @ageprices.to_json
    @activity_business = ActivityBusiness.find(@activity.activity_business_id)
    @holidays = [@activity.monday_open, @activity.tuesday_open, @activity.wednesday_open, @activity.thursday_open,
                 @activity.friday_open, @activity.saturday_open, @activity.sunday_open]
    @members = @project.project_members
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
    end

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
      @booked_activities = @cart.booked_activities.where(is_paid: false)
    end
    @total_price = @booked_activities.sum(:total_price)
    @tax = (@total_price * 0.1).to_i
  end

  def purchase_list
    @project = Project.find(params[:project_id])
    if @project.cart.nil?
      @cart = @project.build_cart
      @cart.save!
    else
      @cart = @project.cart
      @booked_activities = @cart.booked_activities.where(is_paid: true).order(created_at: :desc)
    end
  end
  def favorite_list
    @project = Project.find(params[:project_id])
    @favorites = FavoriteActivity.where(project_id: @project.id)
  end

  def experience_search
  end

  def members_index
    @project = Project.find(params[:project_id])
    @members = @project.project_members
  end

  def thank_you_payment
    @project = Project.find(params[:project_id])
  end

  private
    def member_params
        params.require(:project_member).permit(:nickname, :first_name, :last_name,
                                               :gender, :birth_year, :birth_month, :birth_date)
    end
end
