class Project < ActiveRecord::Base
  has_many :pages

  attr_accessible :title

  validates :title, presence:true, uniqueness:true
end
