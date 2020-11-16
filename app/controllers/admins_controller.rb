class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @admin = Admin.find(current_admin.id)
  end

  def index
  end

  def supplier_index
    @suppliers = Supplier.all
  end

  def supplier_approved_list
    @suppliers = Supplier.joins(:activity_business).where('activity_businesses.is_approved = ?', true)
  end

  def supplier_waiting_list
    @suppliers = Supplier.joins(:activity_business).where('activity_businesses.is_approved = ?', false).where('activity_businesses.status = ?', 'send_approve')
  end

  def supplier_inputing_list
    @suppliers = Supplier.left_joins(:activity_business).where("activity_businesses.id IS NULL").or(Supplier.left_joins(:activity_business).where('activity_businesses.is_approved = ?', false).where('activity_businesses.status = ?', 'inputing'))
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

end
