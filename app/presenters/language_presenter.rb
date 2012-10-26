class LanguagePresenter < BasePresenter
  presents :language

  def history
    h.content_tag(:div, class:'history') do
      sentences
    end if language.sentences.present?
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
          if language.sentences_count > 1
            h.render sentence, comment:Comment.new
          elsif language.sentences_count == 1 && language.comments_present?
            h.render sentence, comment:Comment.new
          else
            h.render 'comments/form', sentence:sentence
          end
        end 
      }.join.html_safe
    end if language.sentences.present? && h.can?(:create, Comment)
  end
end
