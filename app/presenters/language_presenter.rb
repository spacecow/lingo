class LanguagePresenter < BasePresenter
  presents :language

  def history
    h.content_tag(:div, class:'history') do
      h.render 'sentences/sentences', sentences:language.sentences if language.sentences.count > 1
    end
  end
end
