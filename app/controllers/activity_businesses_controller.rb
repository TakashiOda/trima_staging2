class ActivityBusinessesController < ApplicationController
  def index
  end

  # def show
  # end

  def new
    @supplier = current_supplier
    @activity_business = @supplier.build_activity_business
    # binding.pry
    # @activity_business = ActivityBusiness.new(supplier_id: current_supplier.id)
    # @guide = @activity_business.guides.build
  end

  def create
    @supplier = current_supplier
    @activity_business = @supplier.build_activity_business(activity_biz_params)
    # @activity_business = ActivityBusiness.new(activity_biz_params)
    @activity_business.profile_input_done = true
    if @activity_business.save
      redirect_to supplier_path(current_supplier)
    else
      render 'new'
    end
  end

  def edit
    @supplier = current_supplier
    @activity_business = @supplier.activity_business
    if @activity_business.activity_languages.any?
      @language_ids = @activity_business.activity_languages.pluck(:language_id)
    else
      @language_ids = [28]
    end

  end

  def edit_cansel
    @supplier = current_supplier
    @activity_business = @supplier.activity_business
  end

  def edit_insurance
    @supplier = current_supplier
    @activity_business = @supplier.activity_business
  end

  def edit_guides
    @supplier = current_supplier
    @activity_business = @supplier.activity_business
    @guide = @activity_business.guides.build
  end

  def send_approve
    @supplier = current_supplier
    @activity_business = @supplier.activity_business
  end

  def update
    @supplier = current_supplier
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity_business.update_attributes(activity_biz_params)
    if params[:activity_business][:apply_suuplier_address] == 'true'
      @activity_business.post_code = nil
      @activity_business.prefecture_id = nil
      @activity_business.area_id = nil
      @activity_business.town_id = nil
      @activity_business.detail_address = nil
      @activity_business.building = nil
    end
    if params["input_type"] == "cansel_setting"
      @activity_business.cansel_input_done = true
      if @activity_business.save
        flash[:notice] = '体験事業の情報を更新しました'
        redirect_to supplier_path(@supplier)
      else
        render :edit_cansel
      end
    elsif params["input_type"] == "insurance_setting"
      @activity_business.insurance_input_done = true
      if @activity_business.save
        flash[:notice] = '体験事業の情報を更新しました'
        redirect_to supplier_path(@supplier)
      else
        render :edit_insurance
      end
    elsif params["input_type"] == "guides_input"
      if @activity_business.save
        flash[:notice] = '体験事業の情報を更新しました'
        redirect_to supplier_path(@supplier)
      else
        render :edit_guides
      end
    elsif params["input_type"] == "send_approve"
      if @activity_business.save
        flash[:notice] = '申請が送信されました'
        redirect_to supplier_path(@supplier)
      else
        render :send_approve
      end
    else
      if !@activity_business.profile_image.blank? && @activity_business.name && @activity_business.profile_text
        @activity_business.profile_input_done = true
      end
      if @activity_business.save
        flash[:notice] = '体験事業の情報を更新しました'
        redirect_to supplier_path(@supplier)
      else
        render :edit
      end
    end
    # if @activity_business.save
    #   flash[:notice] = '体験事業の情報を更新しました'
    #   redirect_to supplier_path(@supplier)
    # else
    #   render :edit
    # end
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
                                                  :insurance_image, :insurance_image_cache,
                                                  guides_attributes: [:id, :activity_business_id, :name,
                                                  :avatar, :avatar_cache, :introduction, :roll, :speak_japanese,
                                                  :speak_english, :speak_chinese, :other_language, :stop_now,
                                                  :_destroy])
    end

end
