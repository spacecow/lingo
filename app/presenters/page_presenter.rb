class PagePresenter < BasePresenter
  presents :page

  def translations
    h.content_tag(:div, id:'translations') do
      h.render page.translations
    end if page.translations.present?
    #h.render "translations/translations", project:project, page:page, translations:_translations if page.translations.present?
  end
end
