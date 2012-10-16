class TranslationsController < ApplicationController
  load_and_authorize_resource :project, only:[:create,:update]
  load_and_authorize_resource :page, through: :project, only:[:create,:update]
  load_and_authorize_resource :translation, through: :page, only:[:create,:update]

  def new
  end

  def create
    @translation.languages.each{|e| e.user = current_user}
    if @translation.save
      redirect_to [@project,@page], notice:created(:translation)
    else
      #error
    end
  end

  def update
    params[:translation][:languages_attributes].values.map{|e| e[:id]}.each do |id|
      if @translation.languages.find(id).user_id != current_user.id
        language = Japanese.new
        language.user = current_user
        language.save!
      end
    end 
    if @translation.update_attributes(params[:translation])
      redirect_to [@project,@page], notice:updated(:translation)
    else
      p @translation.errors
      #error
    end
  end
end
