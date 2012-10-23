class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic:true

  attr_accessible :content
end
