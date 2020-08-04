class OrganizationsController < ApplicationController
  def index
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @supplier = Supplier.find(params[:supplier_id])
    if @supplier.organization_id.nil?
      @organization = Organization.new
    else
      flash[:alert] = 'すでに組織情報が存在します'
      redirect_to supplier_path(@supplier)
    end
  end

  def create
  end

  def edit
    @supplier = Supplier.find(params[:supplier_id])
    @organization = Organization.find(@supplier.organization_id)
  end

  def update
  end

  def delete_member
  end

  def destroy
  end

  private
    def org_params
        params.require(:organization).permit(:name, :org_type, :state_id,
                                           :prefecture_id, :town_id, :detail_address, :building,
                                           :post_code, :phone, :has_event, :has_spot, :has_activity,
                                           :has_restaurant, :contract_plan, :contract_status)
    end
end
