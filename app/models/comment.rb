class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic:true
  belongs_to :user
  has_many :notifications, as: :notifiable

  attr_accessible :content

  validates :user, presence:true
  validates :content, presence:true

  before_create :create_notification

  def userid; user.username end

  private

    def create_notification
      Notification.notice_from!(self,self.user,:create)
    end
end
