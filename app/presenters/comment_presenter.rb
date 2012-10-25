class CommentPresenter < BasePresenter
  presents :comment

  def by_author
    h.content_tag(:div, id:'author') do
      "by #{h.link_to(comment.userid, comment.user)}".html_safe
    end
  end

  def content
    h.content_tag(:div, id:'content') do
      comment.content
    end
  end
end
