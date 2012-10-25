class TranslationPresenter < BasePresenter
  presents :translation, :page, :project

  def new_java_link
    h.link_to h.new(:translation), h.new_translation_path(project_id:project.id, page_id:page.id), remote:true, id:'new_link' if h.can? :new, Translation
  end
  
  def form(action,active=true)
    h.render "translations/form", project:project, page:page, translation:translation, active:active, presenter:self if h.can? :edit, Translation
  end

  def languages
    h.content_tag(:div, id:'languages') do
      translation.languages.map{|language|
        h.render 'languages/language', language:language
      }.join.html_safe
    end
  end

  def histories
    h.content_tag(:div, id:'histories') do
      translation.languages.map{|language|
        h.render 'languages/history', language:language
      }.join.html_safe
    end
  end
end
