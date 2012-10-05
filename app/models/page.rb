class Page < ActiveRecord::Base
  belongs_to :project

  attr_accessible :no, :image
  mount_uploader :image, ImageUploader

  validates :no, presence:true
end
