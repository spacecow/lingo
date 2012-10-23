class Language < ActiveRecord::Base
  belongs_to :translation
  has_one :popular_sentence, class_name:'Sentence', inverse_of: :language
  has_many :sentences, dependent: :destroy
  accepts_nested_attributes_for :popular_sentence

  attr_accessible :popular_sentence_attributes, :type

  validates :type, presence:true
  validates :translation, presence:true
  #validates :translation_id, uniqueness:{scope:[:type,:user_id]}

  def page; translation.page end
  def project; translation.project end
  def set_initial_user(user)
    popular_sentence.set_initial_user(user)
    #sentences.map{|e| e.set_initial_user(user)}
  end
end
