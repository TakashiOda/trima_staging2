class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @admin = Admin.find(current_admin.id)
    @total_supplier_acount_num = Supplier.all.size
    @total_activity_biz_num = ActivityBusiness.all.size
    @total_waiting_biz_num = ActivityBusiness.where(is_approved: false).where(status: 'send_approve').size
    @total_activities_num = Activity.all.size
    @waiting_activities_num = Activity.where(is_approved: false).where(status: 'published').size
    @published_activities_num = Activity.where(is_approved: true).where(status: 'published').size
    @current_register_suppliers = Supplier.all.order(confirmed_at: "DESC").limit(5)
    # @current_register_suppliers = Supplier.order(:confirmed_at, "DESC")
  end

  def index
  end

  def supplier_index
    @suppliers = Supplier.all.page(params[:page]).per(20)
  end

  def supplier_approved_list
    @suppliers = Supplier.joins(:activity_business).where('activity_businesses.is_approved = ?', true).page(params[:page]).per(20)
  end

  def supplier_waiting_list
    @suppliers = Supplier.joins(:activity_business).where('activity_businesses.is_approved = ?', false).where('activity_businesses.status = ?', 'send_approve').page(params[:page]).per(20)
  end

  def supplier_inputing_list
    @suppliers = Supplier.left_joins(:activity_business).where("activity_businesses.id IS NULL").or(Supplier.left_joins(:activity_business).where('activity_businesses.is_approved = ?', false).where('activity_businesses.status = ?', 'inputing')).page(params[:page]).per(20)
  end

  def supplier_detail
    @supplier = Supplier.find(params[:supplier_id])
    @supplier_profile = @supplier.supplier_profile
    @activity_business = ActivityBusiness.find_by(supplier_id: @supplier.id)
  end

  def supplier_activity_biz_approve
    @activity_business = ActivityBusiness.find(params[:activity_business_id])
    @activity_business.is_approved = params[:activity_business][:is_approved]
    if @activity_business.save
      flash[:notice] = '事業者を承認しました'
      redirect_to supplier_detail_path(@activity_business.supplier_id)
    else
      flash[:alert] = '承認できません'
      render 'supplier_detail'
    end
  end

  def supplier_activity_index
    @activities = Activity.all.page(params[:page]).per(10)
  end

  def supplier_approved_activity_index
    @activities = Activity.where(is_approved: true).page(params[:page]).per(20)
  end

  def supplier_waiting_activity_index
    @activities = Activity.where(is_approved: false).where(status: 'published').page(params[:page]).per(20)
  end

  def supplier_draft_activity_index
    @activities = Activity.where(is_approved: false).where(status: 'draft').page(params[:page]).per(20)
  end

  def supplier_activity_detail
    @activity = Activity.find(params[:activity_id])
    @english_activity_info = ActivityTranslation.find_by(activity_id: params[:activity_id], language_id: 3)
  end

  def activity_approve
    binding.pry
    @activity = Activity.find(params[:activity_id])
    @activity.is_approved = params[:activity][:is_approved]
    if @activity.save
      flash[:notice] = 'アクティビティを承認しました'
      redirect_to supplier_activity_detail_path(@activity.id)
    else
      flash[:alert] = '承認できません'
      render 'supplier_activity_detail'
    end
  end

  def edit
    @admin = Admin.find(current_admin.id)
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      redirect_to admin_path(@admin)
    else
      render 'edit'
    end
  end

  private
    def admin_params
      params.require(:admin).permit(:name, :email)
    end

    def activity_biz_params
      params.require(:activity_business).permit(:is_approved)
    end

    def activity_params
      params.require(:activity).permit(:is_approved)
    end

end
