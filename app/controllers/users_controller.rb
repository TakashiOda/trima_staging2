class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def show
    if current_user
      @user = User.find(params[:id])
      if @user.country_id
        @user_country = Country.find(@user.country_id).name
      end
      if @user.language_id
        @user_language = Language.find(@user.language_id).name
      end
    else
      flash.now[:alert] = 'Plese Sign in'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # binding.pry
    @user = User.find(params[:id])
    # @user.update(user_params)
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:avatar, :avatar_cache, :first_name, :last_name,
                                   :nickname, :country_id, :language_id, :profile_text)
    end

    def update_params
      params.require(:user).permit(:email, :first_name,:last_name, :nickname,
                                  :profile_text, :avatar)
    end
end
