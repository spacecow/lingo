class SentencePresenter < BasePresenter
  presents :sentence

  def author
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

  def timestamp
    h.content_tag(:div, id:'timestamp') do
      h.time_ago_in_words(sentence.updated_at)+" ago"
    end
  end
end
