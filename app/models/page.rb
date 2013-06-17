class Page < ActiveRecord::Base
  belongs_to :project
  has_many :translations

  belongs_to :prev, class_name:'Page',  foreign_key:'prev_id'
  belongs_to :next, class_name:'Page', foreign_key:'next_id'

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
    self.next
  end

  def prev_page
    self.prev
  end

  def set_pos
    self[:pos] = project.pages.count + 1
  end
end
