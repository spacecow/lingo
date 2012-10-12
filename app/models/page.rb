class Page < ActiveRecord::Base
  belongs_to :project
  has_many :translations

  attr_accessible :no, :image
  mount_uploader :image, ImageUploader

  validates :no, presence:true
  validates :project, presence:true
end
