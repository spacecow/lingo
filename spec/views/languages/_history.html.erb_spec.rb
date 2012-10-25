require 'spec_helper'

describe 'languages/history.html.erb' do
  let(:japanese){ create(:japanese) }
  before do
    create(:sentence, language:japanese)
    controller.stub(:current_user){ nil }
  end

  context "containing only one sentence" do
    before{ render 'languages/history', language:japanese }

    describe 'div.history' do
      subject{ Capybara.string(rendered).find('div.history') }
      it{ should have_selector 'div.sentence', count:1 }
    end
  end

  context "containing more than one sentence" do
    before do
      create(:sentence, language:japanese)
      render 'languages/history', language:japanese
    end

    describe 'div.history' do
      subject{ Capybara.string(rendered).find('div.history') }
      it{ should have_selector 'div.sentence', count:2 }
    end
  end
  
end
