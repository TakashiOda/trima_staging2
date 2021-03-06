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
    if @activity_business
      @activities = @activity_business.activities
      @booked = BookedActivity.where(supplier_id: @supplier.id)
      # 欲しいデータ
      # [["日付", 合計予約金額],[],[]]
      @booked6daysBefore = @booked.select { |b6| b6.purchase_date.to_date == (Date.today - 6) }
      @booked5daysBefore = @booked.select { |b5| b5.purchase_date.to_date == (Date.today - 5) }
      @booked4daysBefore = @booked.select { |b4| b4.purchase_date.to_date == (Date.today - 4) }
      @booked3daysBefore = @booked.select { |b3| b3.purchase_date.to_date == (Date.today - 3) }
      @booked2daysBefore = @booked.select { |b2| b2.purchase_date.to_date == (Date.today - 2) }
      @booked1dayBefore = @booked.select { |b1| b1.purchase_date.to_date == (Date.today - 1) }
      @bookedTodayBefore = @booked.select { |b0| b0.purchase_date.to_date == Date.today }
      @data = [
        [(Date.today - 6).strftime("%m/%d"),@booked6daysBefore.sum { |hash| hash[:total_price]}],
        [(Date.today - 5).strftime("%m/%d"),@booked5daysBefore.sum { |hash| hash[:total_price]}],
        [(Date.today - 4).strftime("%m/%d"),@booked4daysBefore.sum { |hash| hash[:total_price]}],
        [(Date.today - 3).strftime("%m/%d"),@booked3daysBefore.sum { |hash| hash[:total_price]}],
        [(Date.today - 2).strftime("%m/%d"),@booked2daysBefore.sum { |hash| hash[:total_price]}],
        [(Date.today - 1).strftime("%m/%d"),@booked1dayBefore.sum { |hash| hash[:total_price]}],
        [Date.today.strftime("%m/%d"),@bookedTodayBefore.sum { |hash| hash[:total_price]}]
      ]
    else
      redirect_to supplier_path(current_supplier.id)
    end
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
