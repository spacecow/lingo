class Page < ActiveRecord::Base
  belongs_to :project
  has_many :translations

  attr_accessible :no, :image
  mount_uploader :image, ImageUploader

  validates :no, presence:true
  validates :project, presence:true
  validates :pos, presence:true, uniqueness:{scope: :project_id}

  def decrease_pos
    self.pos -= 1
  end

  def increase_pos
    self.pos += 1
  end

  def next_page
    _pages = project.pages.order("pos")
    _next_page = _pages.index(self) + 1
    _pages[_next_page]
  end

  def prev_page
    _pages = project.pages.order("pos")
    _prev_page =_pages.index(self) - 1
    return nil if _prev_page < 0
    _pages[_prev_page]
  end

  def set_pos
    self[:pos] = project.pages.count + 1
  end
end
