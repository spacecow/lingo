require 'spec_helper'

describe 'comments/comment.html.erb' do
  let(:user){ create(:user, username:'Batman') }
  let(:comment){ create(:comment, content:'Oh yeah', updated_at:1.hour.ago, user:user) }
  before{ render comment }

  subject{ Capybara.string(rendered)}
  it{ should have_selector 'div#content', text:'Oh yeah' }
  it{ should have_selector 'div.timestamp', text:'about 1 hour ago' }
  it{ should have_selector 'div#author', text:'by Batman' }
end 
