class BasicDatasController < ApplicationController
  def index
    @towns = Town.all
  end
end
