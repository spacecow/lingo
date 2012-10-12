class Language < ActiveRecord::Base
  belongs_to :translation
  attr_accessible :content, :type
end
