class TranslationsController < ApplicationController
  load_and_authorize_resource :project, only:[:create,:update]
  load_and_authorize_resource :page, through: :project, only:[:create,:update]
  authorize_resource :translation, through: :page, only: :create
  load_and_authorize_resource :translation, through: :page, only: :update

  def new
  end

  def create
    arr = languages_attrs(params).map{|k, languages_values|
      sentences_values = sentences_attrs(languages_values)
      sentences_values[:content].blank? ? k : nil
    }.reject{|e| e.nil?}
    arr.each do |id|
      languages_attrs(params).delete(id)
    end
    @translation = @page.translations.build(params[:translation]) 
    @translation.set_initial_user(current_user)
    if @translation.save
      redirect_to [@project,@page], notice:created(:translation)
    else
      #error
    end
  end

  def update
    arr = languages_attrs(params).map{|k, languages_values|
      sentences_values = sentences_attrs(languages_values)
      sentences_values[:content].blank? ? k : nil
    }.reject{|e| e.nil?}
    arr.each do |id|
      languages_attrs(params).delete(id)
    end

    languages_attrs(params).each do |k, languages_values|
      sentences_values = sentences_attrs(languages_values)
      user_id = Sentence.find(sentences_values[:id]).user_id
      if user_id != current_user.id
        sentences_values.delete(:id)
        language = Language.find(languages_values[:id])
        sentence = language.sentences.build(sentences_values)
        sentence.set_initial_user(current_user) 
        language.save! 
        languages_values.delete('popular_sentence_attributes')
      end
    end

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
      params[:popular_sentence_attributes]
      #params[:sentences_attributes]
    end
end
