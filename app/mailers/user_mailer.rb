class UserMailer < ActionMailer::Base
  default :from => "cedarsdev01@gmail.com", :subject => "notification from trima"

  def confirmation_instructions(record)
    @resource = record
    mail(:to => record.email)
  end
end
