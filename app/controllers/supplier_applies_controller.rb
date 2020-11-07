class SupplierAppliesController < ApplicationController

  def new
    @supplier_apply = SupplierApply.new
  end

  def create
    @supplier_apply = SupplierApply.new(apply_params)
    if @supplier_apply.valid?
      @supplier_apply.save
      redirect_to thank_you_for_apply_path
    else
      render 'new'
    end
  end

  def thank_you_for_apply
  end

  def download_supplier_docs
  end

  def index
  end

  def show
  end

  private
    def apply_params
        params.require(:supplier_apply).permit(:company, :name, :prefecture, :town,
                                               :address, :phone, :email, :agree_term)
    end
end
