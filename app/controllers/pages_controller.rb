class PagesController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @page = @project.pages.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @page = @project.pages.build
  end

  def create
    @project = Project.find(params[:project_id])
    @page = @project.pages.build(params[:page])
    if @page.save
      redirect_to @project, notice:created(:page)
    else
      render :new
    end
  end
end
