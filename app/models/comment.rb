class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic:true
  belongs_to :user

  attr_accessible :content

  validates :user, presence:true
  validates :content, presence:true

  def userid; user.username end
end
