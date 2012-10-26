class Notification < ActiveRecord::Base
  belongs_to :notifiable, polymorphic:true
  belongs_to :creator, class_name:'User'
  has_many :noticements

  attr_accessible :type_mask, :content

  validates :notifiable, presence:true
  validates :creator, presence:true
  validates :type_mask, presence:true
  validates :content, presence:true

  before_save :create_noticements

  CREATE = 'create'
  TYPES = [CREATE]

  class << self
    def notice_from!(object,user) 
      notification = object.notifications.build(type_mask:Notification.type(:create), content:object.content)
      notification.creator = user 
      notification.save!
    end

    def type(s) 2**TYPES.index(s.to_s) end
  end

  private

    def create_noticements
      users = User.all.reject{|e| e == self.creator}
      users.each do |user|
        Noticement.notice_to!(self,user) 
      end
    end
end
