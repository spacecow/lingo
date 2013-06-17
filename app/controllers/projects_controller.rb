class ProjectsController < ApplicationController
  #load_and_authorize_resource

  def show
    @project = Project.includes(:pages).find(params[:id])
  end

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new params[:project]
    if @project.save
      redirect_to projects_path, notice:created(:project)
    else
      render :new
    end
  end
end
