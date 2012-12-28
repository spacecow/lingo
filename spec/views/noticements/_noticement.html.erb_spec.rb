require 'spec_helper'

describe 'noticements/_noticement.html.erb', focus:true do
  let(:user){ create(:user, username:'Batman')}
  before do
    create(:user) #needs another user so that a noticement is created
    @sentence = create(:sentence, content:'my content', user:user)
    assert_equal(Notification.count,1)
  end

  context "noticement read" do
    before do
      noticement = Noticement.last
      noticement.unread = false
      noticement.save
      render noticement
    end
    subject{ Capybara.string(rendered)}
    it{ should have_selector 'div.noticement.read'}
  end

  context "noticement unread" do
    let(:noticement){ Noticement.last }
    before{ render noticement }
    subject{ Capybara.string(rendered).find('div.noticement.unread')}
    it{ should have_content 'Create: my content'}
    it{ should have_content 'less than a minute ago by Batman'}
    it{ should have_selector 'div.type', text:'Create:'}
    it{ should have_selector 'div.timestamp', text:'less than a minute ago'}
    
    context 'div.content' do
      subject{ Capybara.string(rendered).find('div.content')}
      it{ should have_link 'my content', href:project_page_path(@sentence.project,@sentence.page, active_id:@sentence.id, read_id:noticement)}
    end

    context "div.author" do
      subject{ Capybara.string(rendered).find('div.author')}
      it{ should have_content 'by Batman'}
      it{ should have_link 'Batman', href:user_path(user)}
    end
  end
end
