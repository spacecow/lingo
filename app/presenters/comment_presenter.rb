class CommentPresenter < BasePresenter
  presents :comment

  def content
    h.content_tag(:div, id:'content') do
      comment.content
    end
  end
end
