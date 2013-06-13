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

  def set_pos
    #_pos = project.pages.count
    #begin _pos += 1
    #end while Page.exists?(pos:_pos,project_id:project.id)
    self[:pos] = project.pages.count + 1
  end
end
