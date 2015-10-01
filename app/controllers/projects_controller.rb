include TimeSeriesInitializer

class ProjectsController < ApplicationController
  def index
    @projects = policy_scope(Project).unarchived.by_last_updated.page(params[:page]).per(7)
    @entry = Entry.new
    @activities = policy_scope(Entry).by_last_created_at.limit(30)
  end

  def show
    authorize resource
    @time_series = time_series_for(resource)
  end

  def edit
    authorize resource
    resource
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    
    authorize @project

    if @project.save
      redirect_to root_path, notice: t(:project_created)
    else
      render action: "new"
    end
  end

  def update
    if resource.update_attributes(project_params)
      redirect_to project_path(resource), notice: t(:project_updated)
    else
      render action: "edit"
    end
  end

  private

  def resource
    @project ||= Project.find_by_slug(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :billable, :client_id, :archived, :description, :budget, :code)
  end
end
