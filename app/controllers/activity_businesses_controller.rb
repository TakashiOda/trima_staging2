class ActivityBusinessesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @supplier = current_supplier
    @activity_business = ActivityBusiness.new(supplier_id: current_supplier.id)
    @guide = @activity_business.guides.build
  end

  def create
    @supplier = current_supplier
    @activity_business = ActivityBusiness.new(activity_biz_params)
    if @activity_business.save
      redirect_to supplier_path(current_supplier)
    else
      render 'new'
    end
  end

  def edit
    @supplier = current_supplier
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
  end

  def update
    @supplier = current_supplier
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
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
        params.require(:activity_business).permit(:name, :profile_image, :profile_image_cache, :profile_text,
                                                  :en_name, :en_profile_text, :cn_name, :cn_profile_text,
                                                  :tw_name, :tw_profile_text, :status,
                                                  { :language_ids=> [] },
                                                  :prefecture_id, :area_id, :town_id,
                                                  :detail_address, :building, :apply_suuplier_address,
                                                  :apply_suuplier_phone, :post_code, :has_insurance,
                                                  :guide_certification, :phone, :no_charge_cansel_before,
                                                  :insurance_image,
                                                  guides_attributes: [:id, :profile_image, :activity_business_id, :name,
                                                  :avatar, :avatar_cache, :introduction, :roll, :speak_japanese,
                                                  :speak_english, :speak_chinese, :other_language, :stop_now,
                                                  :_destroy])
    end

end
