class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @user = User.find(current_user.id)
    @own_projects = Project.where(owner_user_id: current_user.id)
    @invited_projects = current_user.projects.where.not(owner_user_id: current_user.id)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    # @project = Project.new
    # @project.users << current_user
    @project = @user.projects.build
  end

  def create
    # if Project.create(project_params)
    #   redirect_to projects_path, notice: "Add New Project!!"
    # else
    #   render "new"
    # end
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to user_projects_path(current_user)
    else
      render 'new'
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def project_params
      params.require(:project).permit(:name, :start_date, :end_date,
                                      :start_place, :end_place, :owner_user_id,
                                      :destination_area_id,  { user_ids: [] })
    end

end
