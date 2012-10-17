class Language < ActiveRecord::Base
  belongs_to :translation
  has_many :sentences
  accepts_nested_attributes_for :sentences

  attr_accessible :sentences_attributes, :type

  validates :type, presence:true
  #validates :translation_id, uniqueness:{scope:[:type,:user_id]}

  # For nested attributes in form
  after_initialize do |language|
  end

  def set_initial_user(user)
    sentences.map{|e| e.set_initial_user(user)}
  end
end
