class NoticementPresenter < BasePresenter
  presents :noticement

  def by_author
    h.content_tag(:div, class:'author') do
      "by #{h.link_to(noticement.creator_name,noticement.creator)}".html_safe
    end
  end
  def content
    h.content_tag(:div, class:'content') do
      h.link_to(noticement.content,h.project_page_path(noticement.project,noticement.page, active_id:noticement.sentence_id, read_id:noticement.id))
    end
  end
  def type
    h.content_tag(:div, class:'type') do
      noticement.type.capitalize+':'
    end
  end
  def timestamp
    h.content_tag(:div, class:'timestamp') do
      h.time_ago_in_words(noticement.notification_updated_at)+" ago"
    end
  end
end
