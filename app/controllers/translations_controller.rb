class TranslationsController < ApplicationController
  load_and_authorize_resource :project, only:[:create,:update]
  load_and_authorize_resource :page, through: :project, only:[:create,:update]
  load_and_authorize_resource :translation, through: :page, only:[:create,:update]

  def new
  end

  def create
    @translation.set_initial_user(current_user)
    if @translation.save
      redirect_to [@project,@page], notice:created(:translation)
    else
      #error
    end
  end

  def update
    languages_attrs(params).each do |k, languages_values|
      arr = sentences_attrs(languages_values).map{|k, sentences_values|
        user_id = Sentence.find(sentences_values[:id]).user_id
        if user_id != current_user.id
          sentences_values.delete(:id)
          language = Language.find(languages_values[:id])
          sentence = language.sentences.build(sentences_values)
          sentence.set_initial_user(current_user) 
          language.save! 
          k
        else
          nil
        end
      }
      arr.reject{|e| e==nil}.each do |id|
        sentences_attrs(languages_values).delete(id)
      end
    end
    #  if @translation.languages.find(id).user_id != current_user.id
    #    p id
    #    language = Japanese.new
    #    language.user = current_user
    #    language.save!
    #  end
    #end 

    if @translation.update_attributes(params[:translation])
      redirect_to [@project,@page], notice:updated(:translation)
    else
      #error
    end
  end

  private

    def languages_attrs(params)
      params[:translation][:languages_attributes]
    end

    def sentences_attrs(params)
      params[:sentences_attributes]
    end
end
