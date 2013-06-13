class PagePresenter < BasePresenter
  presents :page, :project

  def decrease_pos
    h.link_to '<', h.decrease_pos_path(page_id:page.id), method: :put
  end

  def increase_pos
    h.link_to '>', h.increase_pos_path(page_id:page.id), method: :put
  end

  def pos; page.pos end
  
  def image ver
    h.link_to h.image_tag(page.image_url(:thumb)), [project, page]
  end
  
  def translations
    h.content_tag(:div, id:'translations') do
      h.render page.translations
    end if page.translations.present?
    #h.render "translations/translations", project:project, page:page, translations:_translations if page.translations.present?
  end
end
