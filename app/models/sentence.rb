class Sentence < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  has_many :comments, as: :commentable
  has_many :notifications, as: :notifiable 

  attr_accessible :content

  validates :user, presence:true
  validates :language_id, uniqueness:{scope: :user_id}
  validates :language, presence:true

  after_save :create_notification

  def comments_present?; comments.present? end
  def page; language.page end
  def project; language.project end
  def set_initial_user(user) self.user = user end
  def translation; language.translation end
  def history; "history_#{language.id}" end
  def userid; user.username end

  private

    def create_notification
      Notification.notice_from!(self,self.user)
    end
end
