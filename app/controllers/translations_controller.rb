class TranslationsController < ApplicationController
  def create
    project = Project.find(params[:project_id])
    page = Page.find(params[:page_id])
    translation = page.translations.build(params[:translation])
    if translation.save
      redirect_to [project, page]
    end
  end
end
