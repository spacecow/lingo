require 'spec_helper'

describe 'sentences/sentence.html.erb' do
  let(:user){ create(:user, username:'Batman') }
  let(:sentence){ create(:sentence, user:user, content:'bajs', updated_at:1.hour.ago) }

  context "not logged in" do
    before do
      controller.stub(:current_user){ nil }
      render sentence, comment:Comment.new
    end

    subject{ Capybara.string(rendered) } 
    it{ should have_selector 'div#content', text:'bajs' }
    it{ should_not have_selector 'div#timestamp', text:'about 1 hour ago' }
    it{ should_not have_selector 'div#author', text:'by Batman' }
    it{ should_not have_link 'Batman', href:user_path(user) }
    it{ should_not have_selector 'form#new_comment' }
    it{ should_not have_button 'Create Comment' }
  end

  context "logged in as member" do
    before do
      controller.stub(:current_user){ create(:user) }
      render sentence, comment:Comment.new
    end

    subject{ Capybara.string(rendered) } 
    it{ should have_selector 'div#content', text:'bajs' }
    it{ should have_selector 'div#timestamp', text:'about 1 hour ago' }
    it{ should have_selector 'div#author', text:'by Batman' }
    it{ should have_link 'Batman', href:user_path(user) }

    describe 'form#new_comment' do
      subject{ Capybara.string(rendered).find('form#new_comment')}
      it{ should have_button 'Create Comment' }
    end
  end
end
