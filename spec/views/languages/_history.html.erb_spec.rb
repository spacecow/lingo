require 'spec_helper'

describe 'languages/history.html.erb' do
  let(:japanese){ create(:japanese) }
  before{ create(:sentence, language:japanese) }

  context "containing only one sentence" do
    let(:output){ render 'languages/history', language:japanese }

    describe 'div.history' do
      subject{ Capybara.string(output).find('div.history') }
      it{ should have_selector 'div.sentence', count:1 }
    end
  end

  context "containing more than one sentence" do
    before{ create(:sentence, language:japanese) }
    let(:output){ render 'languages/history', language:japanese }

    describe 'div.history' do
      subject{ Capybara.string(output).find('div.history') }
      it{ should have_selector 'div.sentence', count:2 }
    end
  end
  
end
