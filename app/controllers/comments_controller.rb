class CommentsController < ApplicationController
  load_and_authorize_resource :sentence
  load_and_authorize_resource :comment, through: :sentence 
  
  def create
    if @comment.save
      redirect_to [@sentence.project, @sentence.page]
    end
  end
end
