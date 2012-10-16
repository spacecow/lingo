class Language < ActiveRecord::Base
  belongs_to :translation
  belongs_to :user
  attr_accessible :content, :type

  validates :user, presence:true
  validates :type, presence:true
  validates :translation_id, uniqueness:{scope:[:type,:user_id]}
end
