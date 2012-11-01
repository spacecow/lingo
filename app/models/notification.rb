class Notification < ActiveRecord::Base
  belongs_to :notifiable, polymorphic:true
  belongs_to :creator, class_name:'User'

  has_many :noticements
  has_many :users, through: :noticements

  attr_accessible :type_mask, :content

  validates :notifiable, presence:true
  validates :creator, presence:true
  validates :type_mask, presence:true
  validates :content, presence:true

  before_create :create_noticements

  CREATE = 'create'
  UPDATE = 'update'
  TYPES = [CREATE, UPDATE]

  def creator_name; creator.username end
  def type
    assert_equal(types.first,types.last)
    types.first
  end
  def types
    TYPES.reject{|r| ((type_mask||0) & 2**TYPES.index(r)).zero? }
  end
  def page; notifiable.page end
  def project; notifiable.project end
  def sentence_id; notifiable_id end

  class << self
    def notice_from!(object,user,type) 
      notification = object.notifications.build(type_mask:Notification.type(type), content:object.content)
      notification.creator = user 
      #notification.save!
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
