class UserInvitationMailer < ApplicationMailer

  default from: "trima事務局 <noreply-trima@cedars.jp>"

  def user_invitation(email_params, inviter)
    @invited_user_email = email_params
    @invite_user = inviter
    @url  = 'https://www.uu-trima.com/users/sign_up'
    mail to: @invited_user_email, subject: "#{@invite_user.email}さんがあなたをtrimaに招待しています"
  end

end
