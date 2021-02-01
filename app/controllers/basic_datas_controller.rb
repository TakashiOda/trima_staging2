class BasicDatasController < ApplicationController
  def index
    # @towns = Town.all
    @towns = Town.where.not('jp_name like ?','%--%').page(params[:page]).per(20)
    # @towns = Town.where.not(town_code: "nil")
    # モデル名.where.not('カラム名 like ?','%検索したい文字列%')
  end
end
