class SupplierMailer < ApplicationMailer
  default from:  "trima予約通知 <noreply-trima@cedars.jp>"

  def send_booked_notification(supplier, booked_items) #メソッドに対して引数を設定
    @supplier = supplier
    @booked_items = booked_items
    mail(to: @supplier.email, subject: '【trima予約通知】あなたの体験に予約が入りました')
  end
end
