class SentencePresenter < BasePresenter
  presents :sentence

  def by_author
    h.content_tag(:div, id:'author') do
      "by #{h.link_to(sentence.userid, sentence.user)}".html_safe
    end
  end

  def comments
    h.content_tag(:div, id:'comments') do
      h.render sentence.comments
    end if sentence.comments.present?
  end

  def content
    h.content_tag(:div, id:'content'){ sentence.content }
  end  
end
