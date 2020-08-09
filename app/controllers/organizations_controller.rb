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
          @organization.add_member(params[:invite_emails][:member1], current_supplier) #Organizationのモデルメソッド
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
    @member_emails = []
    @joined_emails = Supplier.where(organization_id: @organization.id).where.not(id: current_supplier.id ).pluck(:email)
    if !@suppliers_emails.nil?
      @joined_emails.each do |joined_email|
        @member_emails.push(joined_email)
      end
    end
    @inviting_emails = OrgInvite.where(organization_id: @organization.id, has_account: 1).pluck(:invited_email)
    if !@inviting_emails.nil?
      @inviting_emails.each do |inviting_email|
        @member_emails.push(inviting_email)
      end
    end
    @left_invite_num = 4 - @member_emails.count
  end

  def update
    @supplier = Supplier.find(params[:supplier_id])
    @organization = Organization.find(@supplier.organization_id)
    prefecture = Prefecture.find(params[:organization][:prefecture_id])
    town = Town.find(params[:organization][:town_id])
    unless town.town_code ==  "nil" || prefecture.local_name.include?("---")
      if @organization.update(org_params)
         @organization.replace_member(params[:invite_emails][:member1], current_supplier) #Organizationのモデルメソッド
         @organization.replace_member(params[:invite_emails][:member2], current_supplier) #Organizationのモデルメソッド
         @organization.replace_member(params[:invite_emails][:member3], current_supplier) #Organizationのモデルメソッド
         @organization.replace_member(params[:invite_emails][:member4], current_supplier) #Organizationのモデルメソッド
         @organization.destroy_unlist_member(params[:invite_emails], current_supplier) #Organizationのモデルメソッド
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

  def member_delete
    @supplier = Supplier.find(params[:supplier_id])
    @member = Supplier.find(params[:member_id])
    if @supplier.control_level == 0
      # @organization = Organization.find(params[:org_id])
      @member.organization_id = nil
      @member.save!
    end
    redirect_to supplier_path(@supplier)
  end

  def invite_delete
    @supplier = Supplier.find(params[:supplier_id])
    # @organization = Organization.find(params[:org_id])
    if @supplier.control_level == 0
      @invite = OrgInvite.find(params[:invite_id])
      @invite.destroy!
    end
    redirect_to supplier_path(@supplier)
  end

  private
    def org_params
        params.require(:organization).permit(:name, :org_type, :state_id,
                                           :prefecture_id, :town_id, :detail_address, :building,
                                           :post_code, :phone, :has_event, :has_spot, :has_activity,
                                           :has_restaurant, :contract_plan, :contract_status, { invite_emails: [] })
    end
end
