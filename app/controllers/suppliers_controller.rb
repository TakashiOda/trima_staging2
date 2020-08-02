class SuppliersController < ApplicationController

  def thank_you_for_registration_supplier
  end

  def index
  end

  def show
    if current_supplier
      @supplier = Supplier.find(params[:id])
    else
      flash.now[:alert] = 'Please Sign in'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def supplier_params
      params.require(:supplier).permit(:avatar, :avatar_cache, :name)
    end

end
