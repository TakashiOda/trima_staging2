class FavoriteActivitiesController < ApplicationController
  before_action :authenticate_user!

  # お気に入り登録
  def create
    @project = Project.find(params[:project_id])
    @activity = Activity.find(params[:activity_id])
    @favorite = FavoriteActivity.create(user_id: current_user.id, activity_id: @activity.id, project_id: @project.id)
    redirect_to project_activity_detail_path(@project, @activity)
  end

  # お気に入り削除
  def destroy
    @project = Project.find(params[:project_id])
    @activity = Activity.find(params[:activity_id])
    @favorite = FavoriteActivity.find_by(user_id: current_user.id, activity_id: @activity.id, project_id: @project.id)
    @favorite.destroy
    redirect_to project_activity_detail_path(@project, @activity)
  end

end
