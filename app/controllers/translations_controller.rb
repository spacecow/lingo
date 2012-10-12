class TranslationsController < ApplicationController
  #authorize_resource, only: :new
  load_and_authorize_resource :project, only:[:create,:update]
  load_and_authorize_resource :page, through: :project, only:[:create,:update]
  load_and_authorize_resource :translation, through: :page, only:[:create,:update]

  def new
  end

  def create
    if @translation.save
      redirect_to [@project,@page], notice:created(:translation)
    else
      #error
    end
  end

  def update
    if @translation.update_attributes(params[:translation])
      redirect_to [@project,@page], notice:updated(:translation)
    else
      #error
    end
  end
end
