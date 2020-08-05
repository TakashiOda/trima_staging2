class SupplierInvitationMailer < ApplicationMailer

  default from: 'cedarsdev01@gmail.com'

  def supplier_invitation(email_params, inviter)
    @invited_user_email = email_params
    @invite_user = inviter
    @url  = 'http://localhost:5000/users/sign_up'
    mail to: @invited_user_email, subject: "#{@invite_user.name}(#{@invite_user.email})さんからtrimaへの招待が届いています"
  end

end
