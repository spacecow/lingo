class Sentence < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  attr_accessible :content

  validates :user_id, presence:true
  validates :language_id, uniqueness:{scope: :user_id}

  def set_initial_user(user) self.user = user end
end
