class SuppliersController < ApplicationController
  before_action :authenticate_supplier!,
  except: [:thank_you_for_registration_supplier, :after_resend_confirmation_supplier, :index]

  def thank_you_for_registration_supplier
  end

  def after_resend_confirmation_supplier
  end

  def index
  end

  def dashboard
    @supplier = current_supplier
    @supplier_profile = @supplier.supplier_profile
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier)
  end

  def show
    @supplier = Supplier.find(params[:id])
    @supplier_profile = @supplier.supplier_profile
    @activity_business = ActivityBusiness.find_by(supplier_id: @supplier.id)
  end

  def edit
    @supplier = Supplier.find(params[:id])
    if @supplier.supplier_profile.nil?
      @supplier.build_supplier_profile
    end
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      flash[:notice] = '事業者情報を更新しました'
      redirect_to supplier_path(@supplier)
    else
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
                                          supplier_profile_attributes: [:supplier_id,
                                                                        :representative_name,
                                                                        :representative_kana,
                                                                        :manager_name,
                                                                        :manager_name_kana,
                                                                        :post_code,
                                                                        :prefecture_id,
                                                                        :area_id,
                                                                        :town_id,
                                                                        :detail_address,
                                                                        :building,
                                                                        :phone,
                                                                        :contract_plan,
                                                                        :is_suspended])
    end
end
