class SupplierlMailer < ActionMailer::Base
  default :from => "cedarsdev01@gmail.com", :subject => "trima運営事務局からのお知らせ"

  def confirmation_instructions(record)
    @resource = record
    mail(:to => record.email)
  end
end
