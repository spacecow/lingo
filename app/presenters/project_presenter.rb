class ProjectPresenter < BasePresenter
  presents :project

  def new_page_link
    h.link_to h.new(:page), h.new_project_page_path(project) if h.can? :new, Page
  end

  def pages
    h.content_tag :div, class: :pages do
      render_pages project.first_page
    end
  end

  def render_pages page
    return if page.nil?
    h.render(page)+render_pages(page.next)
  end
end
