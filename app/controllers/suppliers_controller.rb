class SuppliersController < ApplicationController
  before_action :authenticate_supplier!, except: [:thank_you_for_registration_supplier, :index]

  def thank_you_for_registration_supplier
  end

  def index
  end

  def show
    @supplier = Supplier.find(params[:id])
    unless @supplier.organization_id.nil?
      @organization = Organization.find(@supplier.organization_id)
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      flash[:notice] = '社員情報を更新しました'
      redirect_to supplier_path(@supplier)
    else
      flash[:alert] = '社員情報がおかしいです'
      render 'edit'
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    if @supplier.destroy
      flash[:notice] = '社員情報を更新しました'
      redirect_to root_path
    else
      flash[:alert] = '削除に失敗しました'
      render 'edit'
    end
  end

  private
    def supplier_params
        params.require(:supplier).permit(:avatar, :avatar_cache, :name, :organization_id,
                                         :control_level, :accept_invite)
    end
end
