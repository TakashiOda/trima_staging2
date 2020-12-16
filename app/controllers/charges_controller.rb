class ChargesController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @cart = @project.cart
    @booked_activities = @cart.booked_activities.where(is_paid: false)
    # 欲している体験が一つでも在庫不足しているかチェック
    bookable_arr = []
    @booked_activities.each do |booked_activity|
      if booked_activity.isBookable
        bookable_arr.push("true")
      else
        bookable_arr.push("false")
      end
    end
    # 在庫不足なら処理しない
    if !bookable_arr.include?("false")
      subtotal_price = @cart.booked_activities.sum(:total_price)
      tax = (subtotal_price * 0.1).to_i
      total_price = subtotal_price + tax

      # stripe決済****************************
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

      #rails側の売れたとき処理 *******************************
      @booked_activities.each do |booked_activity|
        # カート内の予約ステータスを支払い済みにする
        booked_activity.hasPaid
        # 在庫を減らす
        booked_activity.reduceStock
      end

      supplier_ids = @booked_activities.pluck(:supplier_id)
      supplier_ids.uniq
      supplier_ids.each do |supplier_id|
        supplier = Supplier.find(supplier_id)
        booked_items = []
        @booked_activities.each do |booked_activity|
          if booked_activity.supplier_id = supplier_id
            booked_items.push(booked_activity)
          end
        end
        SupplierMailer.send_booked_notification(supplier, booked_items).deliver
      end

      redirect_to project_thank_you_payment_path(@project), notice: "商品を購入しました！"
    else
      flash[:alert] = '売り切れになった体験が含まれています'
      redirect_to project_cart_path(@project)
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to project_cart_path(@project)

    #   # stripe関連でエラーが起こった場合
    # rescue Stripe::CardError => e
    # flash[:error] = "#決済(stripe)でエラーが発生しました。{e.message}"
    # render :new
    #
    # # Invalid parameters were supplied to Stripe's API
    # rescue Stripe::InvalidRequestError => e
    #   flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
    #   render :new
    #
    # # Authentication with Stripe's API failed(maybe you changed API keys recently)
    # rescue Stripe::AuthenticationError => e
    #   flash.now[:error] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
    #   render :new
    #
    # # Network communication with Stripe failed
    # rescue Stripe::APIConnectionError => e
    #   flash.now[:error] = "決済(stripe)でエラーが発生しました（APIConnectionError）#{e.message}"
    #   render :new
    #
    # # Display a very generic error to the user, and maybe send yourself an email
    # rescue Stripe::StripeError => e
    #   flash.now[:error] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
    #   render :new
    #
    # # stripe関連以外でエラーが起こった場合
    # rescue => e
    #   flash.now[:error] = "エラーが発生しました#{e.message}"
    #   render :new
    # end
  end

end
