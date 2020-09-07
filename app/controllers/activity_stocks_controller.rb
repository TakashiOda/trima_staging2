class ActivityStocksController < ApplicationController
  def new
    # @activity_business = ActivityBusiness.find_by(supplier_id: current_supplier.id)
    @activity = Activity.find(params[:activity_id])
    s_date = @activity.start_date
    e_date = @activity.end_date
    # @dates = []
    (s_date..e_date).each do |date|
      # @dates.push(date)
      @activity_stock = @activity.activity_stocks.build(stock: 10, date: date)
    end
    # binding.pry
  end

  def edit
  end
end
