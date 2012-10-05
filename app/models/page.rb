class Page < ActiveRecord::Base
  attr_accessible :no, :project_id

  validates :no, presence:true
end
