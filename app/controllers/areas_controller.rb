class AreasController < ApplicationController
  # before_action :authenticate_user!, only: [:edit, :update]

  def index
    @areas = Area.all
  end

  # def show
  #   @area = Area.find(params[:id])
  # end

  # def new
  #   @area = Area.new
  # end

  def create
    @area = Area.new(area_params)
  end

  def edit
    @area = Area.find(params[:id])
  end

  def update
    @area = Area.find(params[:id])
    # @user.update(user_params)
    if @area.update(area_params)
      redirect_to areas_path
    else
      render 'edit'
    end
  end

  private
    def area_params
      params.require(:area).permit(:prefecture_id, :en_name,
                                   :local_name, :cn_name, :tw_name, :image, :map,
                                   :en_introduction, :jp_introduction, :cn_introduction,
                                   :tw_introduction, :nearest_airport, :nearest_big_city,
                                   :season_jan, :season_feb, :season_mar, :season_apr,
                                   :season_may, :season_jun, :season_jul, :season_aug,
                                   :season_sep, :season_oct, :season_nov, :season_dec)
    end

end
