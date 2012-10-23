class Translation < ActiveRecord::Base
  belongs_to :page
  has_many :languages, dependent: :destroy, inverse_of: :translation
  accepts_nested_attributes_for :languages

  attr_accessible :languages_attributes, :x1, :y1, :x2, :y2

  validates :page_id, presence:true

  def english; languages.select{|e| e.type == 'English'}.first end
  def japanese; languages.select{|e| e.type == 'Japanese'}.first end

  def klass(active)
    active ? "active translation" : "translation" 
  end
  def project; page.project end

  def set_initial_user(user)
    languages.map{|e| e.set_initial_user(user)}
  end
end
