class LanguagePresenter < BasePresenter
  presents :language

  def history
    h.content_tag(:div, class:'history') do
      h.render 'sentences/sentences', sentences:language.sentences # if language.sentences.count > 1
    end
  end

  def popular_sentence
    h.content_tag(:div, class:'popular sentence') do
      h.render language.popular_sentence
    end unless language.popular_sentence.nil?
  end

  def sentences
    h.content_tag(:div, id:'sentences') do
      language.sentences.map{|sentence|
        h.content_tag(:div, class:'sentence') do
          h.render sentence, comment:Comment.new
        end 
      }.join.html_safe
    end
  end
end
