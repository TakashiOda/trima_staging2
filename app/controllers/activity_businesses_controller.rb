class ActivityBusinessesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @supplier = current_supplier
    @organization = Organization.find(current_supplier.organization_id)
    # @business = @organization.activity_businesses.build
    @activity_business = ActivityBusiness.new(organization_id: @organization.id)
  end

  def create
    @supplier = current_supplier
    @organization = Organization.find(current_supplier.organization_id)
    @activity_business = ActivityBusiness.new(activity_biz_params)
    if @activity_business.save
      redirect_to supplier_path(current_supplier)
    else
      render 'new'
    end
  end

  def edit
    @supplier = current_supplier
    @organization = Organization.find(current_supplier.organization_id)
    @activity_business = ActivityBusiness.find_by(organization_id: @organization.id)
    @owners = Supplier.where(organization_id: @organization.id, control_level: 0)
  end

  def update
    @supplier = current_supplier
    @activity_business = ActivityBusiness.find_by(organization_id: @supplier.organization.id)
    if @activity_business.update(activity_biz_params)
      flash[:notice] = '体験事業の情報を更新しました'
      redirect_to supplier_path(@supplier)
    else
      flash[:alert] = '情報がおかしいです'
      render 'edit'
    end
  end

  def destroy
    @supplier = current_supplier
    @activity_business = ActivityBusiness.find_by(organization_id: @supplier.organization.id)
    if @activity_business.destroy
      flash[:notice] = '体験事業の情報を削除しました'
      redirect_to supplier_path(@supplier)
    else
      flash[:alert] = '削除に失敗しました'
      render 'edit'
    end
  end

  private
    def activity_biz_params
        params.require(:activity_business).permit(:name, :profile_image, :profile_text,
                                                  :organization_id, :country_id, :state_id,
                                                  :prefecture_id, :area_id, :town_id,
                                                  :detail_address, :building, :apply_org_info,
                                                  :apply_org_bank, :has_insurance, :guide_certification)
    end

end
