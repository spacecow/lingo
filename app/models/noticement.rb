class Noticement < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification
  
  validates :user, presence:true
  validates :notification, presence:true

  def content; notification.content end
  def creator; notification.creator end
  def creator_name; notification.creator_name end
  def klass
    "noticement #{unread ? 'unread' : 'read'}"
  end
  def notification_updated_at; notification.updated_at end
  def page; notification.page end
  def project; notification.project end
  def sentence_id; notification.sentence_id end
  def type; notification.type end

  class << self
    def notice_to!(notification,user)
      noticement = notification.noticements.build
      noticement.user = user
      #noticement.save!
    end
  end
end
