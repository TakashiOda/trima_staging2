class ActivityStocksController < ApplicationController
  def new
    @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:activity_id])
    (1..120).each do |i|
      @activity_stock = @activity.activity_stocks.build(stock: 10, date: Date.today + i)
    end
  end

  def edit
  end
end
