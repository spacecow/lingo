class Noticement < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification
  
  validates :user, presence:true
  validates :notification, presence:true

  class << self
    def notice_to!(notification,user)
      noticement = notification.noticements.build
      noticement.user = user
      noticement.save
    end
  end
end
