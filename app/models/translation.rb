class Translation < ActiveRecord::Base
  belongs_to :page
  has_many :languages
  accepts_nested_attributes_for :languages

  attr_accessible :languages_attributes, :x1, :y1, :x2, :y2

  def english; content(languages.select{|e| e.type == 'English'}.first) end
  def japanese; content(languages.select{|e| e.type == 'Japanese'}.first) end

  private

    def content(lang) lang.content end
end
