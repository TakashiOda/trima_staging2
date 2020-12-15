class SupplierMailer < ApplicationMailer
  default from: 'cedarsdev01@gmail.com'

  def send_booked_notification(booked_items, supplier_ids) #メソッドに対して引数を設定
    # 予約アイテムを事業者ごとにグループ分け
     @supplier = Supplier.find(supplier_ids[0])
     # mail to: @supplier.email, subject: '【trima予約通知】あなたの体験に予約が入りました'
     mail(to: @supplier.email, subject: '【trima予約通知】あなたの体験に予約が入りました')
     # binding.pry
    # supplier_ids.each do |supplier_id|
    #   @supplier = Supplier.find(supplier_id)
    #   @booked_items = []
    #   booked_items.each do |booked_item|
    #     if booked_item.supplier_id = supplier_id
    #       @booked_items.push(booked_item)
    #     end
    #   end
    #   mail to: @supplier.email, subject: '【trima予約通知】あなたの体験に予約が入りました'
    # end
  end

end
