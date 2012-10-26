class SentencePresenter < BasePresenter
  presents :sentence

  def by_author
    h.content_tag(:div, id:'author') do
      "by #{h.link_to(sentence.userid, sentence.user)}".html_safe
    end
  end

  def comments
    h.content_tag(:div, id:'comments') do
      sentence.comments.map do |comment|
        h.content_tag(:div, class:'comment') do
          h.render comment
        end
      end.join.html_safe
    end if sentence.comments.present? && h.can?(:show, Comment)
  end

  def content
    h.content_tag(:div, id:'content'){ sentence.content }
  end  
end
