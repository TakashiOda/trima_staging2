class Organization < ApplicationRecord
  has_many :suppliers, dependent: :destroy
  has_many :org_invites, dependent: :destroy
  has_one :activity_business, dependent: :destroy

  validates  :name,   length: { maximum: 30, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates  :state_id, numericality: { only_integer: true }, allow_nil: true
  validates  :prefecture_id, numericality: { only_integer: true }, allow_nil: true
  validates  :town_id, numericality: { only_integer: true }, allow_nil: true
  validates  :detail_address,   length: { maximum: 60, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates  :building,   length: { maximum: 60, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :has_event, inclusion: {in: [true, false]}, allow_nil: true
  validates :has_spot, inclusion: {in: [true, false]}, allow_nil: true
  validates :has_activity, inclusion: {in: [true, false]}, allow_nil: true
  validates :has_restaurant, inclusion: {in: [true, false]}, allow_nil: true
  validates :contract_plan, inclusion: {in: [0, 1]}, allow_nil: true
  validates :contract_status, inclusion: {in: [0, 1]}, allow_nil: true
  # validates :post_code, format: { with: /\A\d{3}\-?d{4}\z/ }, allow_nil: true

  def send_invite_email(email_params, inviter)
   SupplierInvitationMailer.supplier_invitation(email_params, inviter).deliver_now
  end

  def add_member(email_params, inviter)
    unless email_params.blank?
      @supplier = Supplier.find_by(email: email_params)
      @invited = OrgInvite.find_by(organization_id: self.id, invited_email: email_params)
      if !@supplier.nil?
        @supplier.update(organization_id: self.id, control_level: 1, accept_invite: 1)
      elsif @invited.nil?
        OrgInvite.create(organization_id: self.id, inviter_id: inviter.id, invited_email: email_params)
        self.send_invite_email(email_params, inviter)
      end
    end
  end

  def replace_member(email_params, inviter)
    unless email_params.blank?
      @supplier = Supplier.find_by(email: email_params)
      @invited = OrgInvite.find_by(organization_id: self.id, invited_email: email_params)
      if !@supplier.nil?
        @supplier.update(organization_id: self.id, control_level: 1, accept_invite: 1)
      elsif @invited.nil?
        OrgInvite.create(organization_id: self.id, inviter_id: inviter.id, invited_email: email_params)
        self.send_invite_email(email_params, inviter)
      end
    end
  end

  def destroy_unlist_member(params, current_supplier)
    member_emails = []
    member_emails.push(current_supplier.email)
    member_emails.push(params[:member1]) if !params[:member1].blank?
    member_emails.push(params[:member2]) if !params[:member2].blank?
    member_emails.push(params[:member3]) if !params[:member3].blank?
    member_emails.push(params[:member4]) if !params[:member4].blank?
    Supplier.where.not(email: member_emails).update_all(organization_id: nil)
    OrgInvite.where.not(invited_email: member_emails).delete_all
  end

end
