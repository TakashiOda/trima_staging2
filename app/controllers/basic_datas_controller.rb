class BasicDatasController < ApplicationController
  def index
    @towns = Town.all
    # @towns = Town.where.not(town_code: "nil")
  end
end
