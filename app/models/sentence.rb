class Sentence < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  has_many :comments, as: :commentable

  attr_accessible :content

  validates :user, presence:true
  validates :language_id, uniqueness:{scope: :user_id}
  validates :language, presence:true

  def comments_present?; comments.present? end
  def page; language.page end
  def project; language.project end
  def set_initial_user(user) self.user = user end
  def history; "history_#{language.id}" end
  def userid; user.username end
end
