class Organization < ApplicationRecord
  has_many :suppliers, dependent: :destroy

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
      unless @supplier.nil?
        @supplier.update(organization_id: self.id, control_level: 1, accept_invite: 1)
      else
        OrgInvite.create(organization_id: self.id, inviter_id: inviter.id, invited_email: email_params)
        self.send_invite_email(email_params, inviter)
      end
    end
  end

  def replace_member(email_params, inviter)
    unless email_params.blank?
      @supplier = Supplier.find_by(email: email_params)
      unless @supplier.nil?
        @supplier.update(organization_id: self.id, control_level: 1, accept_invite: 1)
      else
        OrgInvite.create(organization_id: self.id, inviter_id: inviter.id, invited_email: email_params)
        self.send_invite_email(email_params, inviter)
      end
    end
  end

end
