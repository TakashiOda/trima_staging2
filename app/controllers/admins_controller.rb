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

  def supplier_detail
    @supplier = Supplier.find(params[:supplier_id])
    @supplier_profile = @supplier.supplier_profile
    @activity_business = ActivityBusiness.find_by(supplier_id: @supplier.id)
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

end
