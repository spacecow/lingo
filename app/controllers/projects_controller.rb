class ProjectsController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def index
  end

  def new
  end

  def create
    if @project.save
      redirect_to projects_path, notice:created(:project)
    else
      render :new
    end
  end
end
