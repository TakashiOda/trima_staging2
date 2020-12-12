class ChargesController < ApplicationController

  def create
    # cartの合計金額を渡す


    # stripeに情報渡す
  end

  def create
    @project = Project.find(params[:project_id])
    @cart = @project.cart
    subtotal_price = @cart.booked_activities.sum(:total_price)
    tax = (subtotal_price * 0.1).to_i
    total_price = subtotal_price + tax

    booked_items = []
    @cart.booked_activities.each do |item|
      activity_name = Activity.find(item.activity_id).name
      booked_items.push(("Activity: #{activity_name}/Date: #{item.activity_date}/Price: #{item.total_price}").to_s)
    end

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: total_price,
      description: "テストです",
      currency: "jpy",
    })
    #rails側の売れたとき処理
    # 1.カート内の全予約のステータスを全て支払い済みにする
    # 2.予約詳細情報（purchase モデル？）を作成
    # 3.cartの中身をゼロにする

    # 1~3がOKなら
    # if @product.update(sold_flg: true)
    #   redirect_to product_path(params[:id]), notice: "商品を購入しました！"
    # end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
