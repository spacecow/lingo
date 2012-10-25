require 'spec_helper'

describe 'languages/histories.html.erb' do
  let(:translation){ create(:translation) }
  let(:japanese){ create(:japanese, translation:translation) }
  let(:english){ create(:english, translation:translation) }
  before do
    create(:sentence, language:japanese)
    create(:sentence, language:english)
    controller.stub(:current_user){ nil }
    present translation do |p| @p = p end
  end

  context "containing languages with only one sentence" do
    let(:output){ render 'languages/histories', presenter:@p }
    subject{ Capybara.string(output) }
    it{ should have_selector 'div.history', count:2 }
  end

  context "containing language with more than one sentence" do
    before{ create(:sentence, language:japanese) }
    let(:output){ render 'languages/histories', presenter:@p }
    subject{ Capybara.string(output) }
    it{ should have_selector 'div.history', count:2 }
  end
end
