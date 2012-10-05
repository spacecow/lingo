class ProjectsController < ApplicationController
  def show
  end

  def index
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save 
      redirect_to projects_path, notice:created(:project)
    else
      render :new
    end
  end
end
