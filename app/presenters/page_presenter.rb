class PagePresenter < BasePresenter
  presents :page, :project

  def current_pos
    "Page #{page.pos}"
  end

  def decrease_pos
    h.link_to '<', h.decrease_pos_path(page_id:page.id), method: :put
  end

  def increase_pos
    h.link_to '>', h.increase_pos_path(page_id:page.id), method: :put
  end

  def navigator
    h.render 'navigator', page:page
  end

  def next_pos
    _next_page = page.next_page
    return "" unless _next_page
    h.link_to "Page #{_next_page.pos} >", h.project_page_path(_next_page.project, _next_page)
  end
  
  def pos; page.pos end

  def prev_pos
    _prev_page = page.prev_page
    return "" unless _prev_page
    h.link_to "< Page #{_prev_page.pos}", h.project_page_path(_prev_page.project, _prev_page)
  end
  
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
