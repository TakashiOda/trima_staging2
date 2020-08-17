class OrganizationsController < ApplicationController
  before_action :authenticate_supplier!
  attr_reader :invite_emails

  def index
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @supplier = Supplier.find(params[:supplier_id])
    if @supplier.organization_id.nil?
      @organization = Organization.new
      @left_invite_num = 4
      # @members = Supplier.where(organization_id: @organization.id)
    else
      flash[:alert] = 'すでに組織情報が存在します'
      redirect_to supplier_path(@supplier)
    end
  end

  def create
    @supplier = Supplier.find(params[:supplier_id])
    if @supplier.organization_id.nil?
      @organization = Organization.new(org_params)
      prefecture = Prefecture.find(params[:organization][:prefecture_id])
      town = Town.find(params[:organization][:town_id])
      unless town.town_code ==  "nil" || prefecture.local_name.include?("---")
        if @organization.save
          @supplier.update(organization_id: @organization.id)
          @organization.add_member(params[:invite_emails][:member], current_supplier) #Organizationのモデルメソッド
          @organization.add_member(params[:invite_emails][:member2], current_supplier) #Organizationのモデルメソッド
          @organization.add_member(params[:invite_emails][:member3], current_supplier) #Organizationのモデルメソッド
          @organization.add_member(params[:invite_emails][:member4], current_supplier) #Organizationのモデルメソッド
          flash[:notice] = '組織情報を作成しました'
          redirect_to supplier_path(@supplier)
        else
          flash[:alert] = '組織情報の作成に失敗しました'
          render 'new'
        end
      else
        flash[:alert] = '市町村を正しく選択してください'
        render 'new'
      end
    else
      flash[:alert] = 'すでに組織情報が存在します'
      redirect_to supplier_path(@supplier)
    end
  end

  def edit
    @supplier = Supplier.find(params[:supplier_id])
    @organization = Organization.find(@supplier.organization_id)
    @suppliers = Supplier.where(organization_id: @organization.id).where.not(id: current_supplier.id )
    @inviting_suppliers = OrgInvite.where(organization_id: @organization.id, has_account: 1)
    if !@suppliers.nil?
      @left_invite_num = 4 - @suppliers.count
      if !@inviting_suppliers.nil?
        @left_invite_num -= @inviting_suppliers.count
      end
    end
  end

  def update
    @supplier = Supplier.find(params[:supplier_id])
    @organization = Organization.find(@supplier.organization_id)
    prefecture = Prefecture.find(params[:organization][:prefecture_id])
    town = Town.find(params[:organization][:town_id])
    unless town.town_code ==  "nil" || prefecture.local_name.include?("---")
      if @organization.update(org_params)
         @organization.replace_member(params[:invite_emails][:member], current_supplier) #Organizationのモデルメソッド
         @organization.replace_member(params[:invite_emails][:member2], current_supplier) #Organizationのモデルメソッド
         @organization.replace_member(params[:invite_emails][:member3], current_supplier) #Organizationのモデルメソッド
         @organization.replace_member(params[:invite_emails][:member4], current_supplier) #Organizationのモデルメソッド
         #member 0~4と管理者以外のsupplierのidはnilにする
        new_member_ids = []
        new_member_ids.push(@supplier.id)
        new_member = Supplier.find_by(email: params[:invite_emails][:member]) if !params[:invite_emails][:member].blank?
        new_member_ids.push(new_member.id) if !new_member.nil?
        new_member2 = Supplier.find_by(email: params[:invite_emails][:member2]) if !params[:invite_emails][:member2].blank?
        new_member_ids.push(new_member2.id) if !new_member2.nil?
        new_member3 = Supplier.find_by(email: params[:invite_emails][:member3]) if !params[:invite_emails][:member3].blank?
        new_member_ids.push(new_member3.id) if !new_member3.nil?
        new_member4 = Supplier.find_by(email: params[:invite_emails][:member4]) if !params[:invite_emails][:member4].blank?
        new_member_ids.push(new_member4.id) if !new_member4.nil?
        Supplier.where.not(id: new_member_ids).update_all(organization_id: nil)

         flash[:notice] = '組織情報を更新しました'
         redirect_to supplier_path(@supplier)
      else
        flash[:alert] = '組織情報を更新できませんでした'
        render 'edit'
      end
    else
      flash[:alert] = '都道府県・市町村を正しく選択してください'
      render 'edit'
    end
  end

  def delete_member
  end

  def destroy
    @supplier = Supplier.find(params[:supplier_id])
    @organization = Organization.find(params[:id])
    @other_member = Supplier.where(organization_id: @organization.id).where.not(id: @supplier.id ).first
    if @supplier.control_level = 0
      if @other_member.nil?
        flash[:notice] = '組織を削除し所属ユーザーを全て削除しました'
        redirect_to root_path
      else
        flash[:alert] = '他に所属しているユーザーが存在するため削除できません'
      end
    else#管理者以外は権限なし
      flash[:alert] = '削除権限がありません。管理者ユーザーのみ削除可能です'
    end
    render 'edit'
  end

  private
    def org_params
        params.require(:organization).permit(:name, :org_type, :state_id,
                                           :prefecture_id, :town_id, :detail_address, :building,
                                           :post_code, :phone, :has_event, :has_spot, :has_activity,
                                           :has_restaurant, :contract_plan, :contract_status, { invite_emails: [] })
    end
end
