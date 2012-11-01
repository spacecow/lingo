require 'spec_helper'

describe 'noticements/_noticement.html.erb' do
  let(:user){ create(:user, username:'Batman')}
  before do
    create(:user) #needs another user so that a noticement is created
    @sentence = create(:sentence, content:'my content', user:user)
    assert_equal(Notification.count,1)
    render Noticement.last
  end

  subject{ Capybara.string(rendered)}
  it{ should have_content 'Create: my content'}
  it{ should have_content 'less than a minute ago by Batman'}
  it{ should have_selector 'div.type', text:'Create:'}
  it{ should have_selector 'div.timestamp', text:'less than a minute ago'}
  
  context 'div.content', focus:true do
    subject{ Capybara.string(rendered).find('div.content')}
    it{ should have_link 'my content', href:project_page_path(@sentence.project,@sentence.page, active_id:@sentence.id)}
  end

  context "div.author" do
    subject{ Capybara.string(rendered).find('div.author')}
    it{ should have_content 'by Batman'}
    it{ should have_link 'Batman', href:user_path(user)}
  end
end
