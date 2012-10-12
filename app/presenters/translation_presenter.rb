class TranslationPresenter < BasePresenter
  presents :translation, :page, :project

  def new_java_link
    h.link_to h.new(:translation), h.new_translation_path(project_id:project.id, page_id:page.id), remote:true, id:'new_link' if h.can? :new, Translation
  end
  
  def form(action,active=true)
    h.render "translations/form", project:project, page:page, translation:translation, active:false if h.can? action, Translation
  end
  
  def translations
    h.render "translations/translations", project:project, page:page, translations:page.translations if page.translations.present?
  end
end
