require 'spec_helper'

describe 'languages/histories.html.erb' do
  let(:translation){ create(:translation) }
  let(:japanese){ create(:japanese, translation:translation) }
  let(:english){ create(:english, translation:translation) }
  before{ create(:sentence, language:japanese) }
  before{ create(:sentence, language:english) }

  context "containing languages with only one sentence" do
    let(:output){ render 'languages/histories', languages:translation.languages }
    subject{ Capybara.string(output) }
    it{ should_not have_selector 'div.history' }
  end

  context "containing language with more than one sentence" do
    before{ create(:sentence, language:japanese) }
    let(:output){ render 'languages/histories', languages:translation.languages }
    subject{ Capybara.string(output) }
    it{ should have_selector 'div.history', count:1 }
  end
end
