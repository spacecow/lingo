class Project < ActiveRecord::Base
  has_many :pages

  belongs_to :first_page, class_name:'Page', foreign_key:'first_id'
  belongs_to :last_page, class_name:'Page', foreign_key:'last_id'

  attr_accessible :title

  validates :title, presence:true, uniqueness:true
end
