class PosController < ApplicationController
  def decrease
    page = Page.find params[:page_id]
    if page_before = Page.find_by(pos:page.pos-1, project_id:page.project_id)
      switch_pos page_before, page
    else
      page.decrease_pos
      page.save!
    end
    redirect_to :back
  end

  def increase
    page = Page.find params[:page_id]
    if page_after = Page.find_by(pos:page.pos+1,project_id:page.project.id)
      switch_pos page, page_after
    else
      page.increase_pos
      page.save!
    end
    redirect_to :back
  end

  private

    def switch_pos(p1,p2)
      temp, p1.pos = p1.pos, 666; p1.save!
      p2.pos, temp = temp, p2.pos; p2.save!
      p1.pos = temp; p1.save!
    end
end
