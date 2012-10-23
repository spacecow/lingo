require 'spec_helper'

describe 'sentences/sentence.html.erb' do
  let(:user){ create(:user, username:'Batman') }
  let(:sentence){ create(:sentence, user:user, content:'bajs', updated_at:1.hour.ago) }
  before do
    present sentence do |presenter|
      @presenter = presenter
    end
  end
  let(:output){ render "sentences/sentence", presenter:@presenter, comment:Comment.new }

  describe "div.sentence" do
    subject{ Capybara.string(output).find('div.sentence') } 
    it{ should have_selector 'div#content', text:'bajs' }
    it{ should have_selector 'div#timestamp', text:'about 1 hour ago' }
    it{ should have_selector 'div#author', text:'by Batman' }
    it{ should have_link 'Batman', href:user_path(user) }
    it{ should have_selector 'form#new_comment' }
    it{ should have_button 'Create Comment' }
  end
end
