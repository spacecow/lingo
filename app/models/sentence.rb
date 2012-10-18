class Sentence < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  attr_accessible :content

  validates :user, presence:true
  validates :language_id, uniqueness:{scope: :user_id}
  validates :language, presence:true

  def set_initial_user(user) self.user = user end
  def userid; user.username end
end
