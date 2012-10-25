require 'spec_helper'

describe 'languages/language.html.erb' do
  let(:japanese){ create(:japanese) }

  context "without sentences" do
    before{ render japanese }

    describe 'div.language' do
      subject{ Capybara.string(rendered).find('div.language')}
      it{ should_not have_selector 'div.popular.sentence' }
    end
  end

  context "with sentences" do
    before do
      controller.stub(:current_user){ nil }
      create(:sentence, language:japanese, content:'oh yeah')
      render japanese
    end

    describe 'div.language' do
      subject{ Capybara.string(rendered).find('div.language')}
      it{ should have_selector 'div.popular.sentence' }

      describe 'div.popular.sentence' do
        subject{ Capybara.string(rendered).find('div.language div.sentence.popular')}
        it{ should have_content 'oh yeah' }
        it{ should_not have_selector 'div.sentence' }
      end
    end
  end
end
