class CommentsController < ApplicationController
  load_and_authorize_resource :sentence, only: :create
  load_and_authorize_resource :comment, through: :sentence, only: :create
  
  def create
    @comment.user = current_user 
    if @comment.save
      redirect_to [@sentence.project, @sentence.page], notice:created(:comment)
    else
      redirect_to [@sentence.project, @sentence.page], alert:'Comment cannot be blank'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:fuck)
    end
end
