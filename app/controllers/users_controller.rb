class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:thank_you_for_registration_user,
                                              :after_resend_confirmation_user,
                                              :index]

  def thank_you_for_registration_user
  end

  def after_resend_confirmation_user
  end

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
      flash.now[:alert] = 'Please Sign in'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:avatar, :avatar_cache, :first_name, :last_name,
                                   :country_id, :language_id, :gender,
                                   :birth_year, :birth_month, :birth_day, :phone,
                                   :post_code, :prefecture, :town, :detail_address, :building,
                                   :emergency_person_name, :emergency_person_relation,
                                   :emergency_person_email, :emergency_person_country_code,
                                   :emergency_person_phone,
                                 )
    end

end
