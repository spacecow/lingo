class PagesController < ApplicationController
  load_and_authorize_resource

  def show
    @project = Project.find(params[:project_id])
    @page = @project.pages.find(params[:id])
    @translations = @page.translations
    @translation = Translation.new(x1:100, y1:100, x2:400, y2:400)
    @translation.languages << Japanese.new
    @translation.languages.last.popular_sentence = Sentence.new
    @translation.languages << English.new
    @translation.languages.last.popular_sentence = Sentence.new
    @active_id = params[:active_id].to_i
    if params[:read_id]
      noticement = Noticement.find(params[:read_id])
      noticement.unread = false
      noticement.save if can? :edit, noticement
    end
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

  def edit
    @project = Project.find(params[:project_id])
  end

  def update
    @project = Project.find(params[:project_id])
    if @page.update_attributes(params[:page])
      redirect_to [@project,@page], notice:updated(:page)
    end
  end
end
