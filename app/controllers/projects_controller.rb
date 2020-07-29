class ProjectsController < ApplicationController
  before_action :authenticate_user!
  attr_reader :invite_emails

  def index
    # @user = User.find(current_user.id)
    @owns = Project.where(owner_user_id: current_user.id)

    invited_pro_ids = UserProject.where(user_id: current_user.id, accept_invite: 0).pluck(:project_id)
    @inviteds = []
    invited_pro_ids.each do |invited_pro_id|
      accept_project = Project.find(invited_pro_id)
      unless accept_project.owner_user_id == current_user.id
        @inviteds.push(accept_project)
      end
    end

    waiting_pro_ids = UserProject.where(user_id: current_user.id, accept_invite: 1).pluck(:project_id)
    @waitings = []
    waiting_pro_ids.each do |waiting_pro_id|
      wait_project = Project.find(waiting_pro_id)
      unless wait_project.owner_user_id == current_user.id
        @waitings.push(wait_project)
      end
    end
    # binding.pry
    # @waiting_projects.is_a?(Array)
    # @invited_projects = current_user.projects.where.not(owner_user_id: current_user.id)
  end

  def show
    @project = Project.find(params[:id])
    @accept_invite = UserProject.find_by(user_id: current_user.id, project_id: @project.id).accept_invite
    # @user_projects = UserProject.where(project_id: @project.id).where.not(user_id: current_user.id)
    @user_projects = UserProject.where(project_id: @project.id)
  end

  def accept_project
    @user_project = UserProject.find_by(user_id: current_user.id, project_id: params[:id])
    @user_project.accept_invite = 0
    if @user_project.save
      flash[:notice] = 'You Accepted Project!'
      redirect_to user_project_path(current_user, params[:id])
    else
      render 'show'
    end
  end

  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.build
  end

  def create
    # binding.pry
    @project = Project.new(project_params)

    if @project.save
      unless params[:invite_emails][:member01].blank?
        @member1 = User.find_by(email: params[:invite_emails][:member01])
        unless @member1.nil?
          @member1_join = UserProject.new(project_id: @project.id, user_id: @member1.id,
                                             control_level: 1, accept_invite: 1)
          @member1_join.save!
        end
      end
      unless params[:invite_emails][:member02].blank?
        @member2 = User.find_by(email: params[:invite_emails][:member02])
        unless @member2.nil?
          @member2_join = UserProject.new(project_id: @project.id, user_id: @member2.id,
                                             control_level: 1, accept_invite: 1)
          @member2_join.save!
        end
      end
      @userProject = UserProject.new(project_id: @project.id, user_id: current_user.id,
                                         control_level: 0, accept_invite: 0)
      @userProject.save!
      redirect_to user_projects_path(current_user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @project = Project.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @project = Project.find(params[:id])
    if @project.update(project_params)
      # メールフォームが空ではないか
      unless params[:invite_emails][:member01].blank?
        @member1 = User.find_by(email: params[:invite_emails][:member01])
        # メールアドレスに該当するユーザーが存在するか
        unless @member1.nil?
          @member1_join = UserProject.find_by(project_id: @project.id, user_id: @member1.id)
          # ユーザーがまだプロジェクトに加入していない
          unless @member1_join
            @member1_join = UserProject.new(project_id: @project.id, user_id: @member1.id,
                                               control_level: 1, accept_invite: 1)
            @member1_join.save!
          end
        end
      end
      unless params[:invite_emails][:member02].blank?
        @member2 = User.find_by(email: params[:invite_emails][:member02])
        # メールアドレスに該当するユーザーが存在するか
        unless @member2.nil?
          @member2_join = UserProject.find_by(project_id: @project.id, user_id: @member2.id)
          # ユーザーがまだプロジェクトに加入していない
          unless @member2_join
            @member2_join = UserProject.new(project_id: @project.id, user_id: @member2.id,
                                               control_level: 1, accept_invite: 1)
            @member2_join.save!
          end
        end
      end
      redirect_to user_project_path(@user, @project)
    else
      render 'edit'
    end
  end

  def member_delete
    # @project = Project.find(params[:id])
    @user_pro = UserProject.find_by(user_id: params[:member_id], project_id: params[:id])
    if @user_pro.destroy
      flash[:notice] = 'Member Deleted!!'
      redirect_to user_project_path(current_user, params[:id])
    else
      render 'show'
    end
  end

  def destroy
  end

  private
    def project_params
      params.require(:project).permit(:name, :start_date, :end_date,
                                      :start_place, :end_place, :owner_user_id,
                                      :destination_area_id, { invite_emails: [] })
    end

    def member_destroy_params
      params.require(:project).permit(:id, :user_id, :member_id)
    end

end
