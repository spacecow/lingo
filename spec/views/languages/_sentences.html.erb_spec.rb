require 'spec_helper'

describe 'languages/sentences.html.erb' do
  let(:language){ create(:japanese) }
  let!(:sentence){ create(:sentence, language:language, content:'oh yeah')}
  before do
    present language do |p| @p = p end
    controller.stub(:current_user){ nil }
    render 'languages/sentences', presenter:@p
  end

  describe 'div#sentences' do
    subject{ Capybara.string(rendered).find('div#sentences') }
    it{ should have_selector 'div.sentence', count:1 }
    it{ should have_content 'oh yeah' }
  end
end
