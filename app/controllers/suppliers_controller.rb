class SuppliersController < ApplicationController
  before_action :authenticate_supplier!, except: [:thank_you_for_registration_supplier, :index]

  def thank_you_for_registration_supplier
  end

  def index
  end

  def show
    @supplier = Supplier.find(params[:id])
    @supplier_profile = @supplier.supplier_profile
    @activity_business = ActivityBusiness.find_by(supplier_id: @supplier.id)
    # if !@supplier.organization_id.nil?
      # @organization = Organization.find(@supplier.organization_id)
      # @joined_members = Supplier.where(organization_id: @organization.id).where.not(id: current_supplier.id)
      # @inviting_members = OrgInvite.where(organization_id: @organization.id, accept_invite: 1)
    # end
  end

  def edit
    @supplier = Supplier.find(params[:id])
    if @supplier.supplier_profile.nil?
      @supplier.build_supplier_profile
    end
    # @supplier.build_supplier_profile
  end

  def update
    @supplier = Supplier.find(params[:id])
    # binding.pry
    if @supplier.update(supplier_params)
      flash[:notice] = '事業者情報を更新しました'
      redirect_to supplier_path(@supplier)
    else
      flash[:alert] = '事業者情報がおかしいです'
      render 'edit'
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    if @supplier.destroy
      flash[:notice] = '事業者情報を更新しました'
      redirect_to root_path
    else
      flash[:alert] = '削除に失敗しました'
      render 'edit'
    end
  end

  def business_list
  end


  private
    def supplier_params
        params.require(:supplier).permit(:avatar, :avatar_cache, :name,
                                          supplier_profile_attributes: [:supplier_id, :manager_name,
                                          :post_code, :prefecture_id, :area_id, :town_id,
                                          :detail_address, :building, :phone, :contract_plan,
                                          :is_suspended])
    end
end
