class PosController < ApplicationController
  def decrease
    page = Page.find params[:page_id]
    switch_page page.prev if page.prev
    redirect_to :back
  end

  def increase
    page = Page.find params[:page_id]
    switch_page page if page.next
    redirect_to :back
  end

  private

    def switch_page page
      if page.prev
        page.prev.next = page.next 
        page.prev.save
      end

      if page.next.next
        page.next.next.prev = page
        page.next.next.save
      end

      page.next.prev = page.prev
      page.prev = page.next
      page.next = page.next.next
      page.prev.next = page

      page.project.first_page = page.prev if page.prev.prev.nil?
      page.project.last_page = page if page.next.nil?
      page.project.save

      page.prev.save
      page.save
    end

    def switch_pos(p1,p2)
      temp, p1.pos = p1.pos, 666; p1.save!
      p2.pos, temp = temp, p2.pos; p2.save!
      p1.pos = temp; p1.save!
    end
end
