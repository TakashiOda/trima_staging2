class UserInvitationMailer < ApplicationMailer

  default from: 'cedarsdev01@gmail.com'

  def user_invitation(email_params, inviter)
    @invited_user_email = email_params
    @invite_user = inviter
    @url  = 'https://www.uu-trima.com/users/sign_up'
    mail to: @invited_user_email, subject: "#{@invite_user.username}has invited you for trima"
  end

end
