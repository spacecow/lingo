class Language < ActiveRecord::Base
  belongs_to :translation
  attr_accessible :content, :type

  def input_html(active)
    {class: :active} if active
  end
end
