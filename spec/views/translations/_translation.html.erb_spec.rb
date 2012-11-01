require 'spec_helper'

describe 'translations/translation.html.erb' do
  let(:translation){ create(:translation) }
  
  context "not logged in" do
    before do
      controller.stub(:current_user){ nil }
      render translation
    end

    describe 'div.translation' do
      subject{ Capybara.string(rendered).find('div.translation')}
      it{ should_not have_selector "form#edit_translation_#{translation.id}" }
      it{ should have_selector 'div#languages' }
    end
  end

  context "member logged in" do
    before do
      controller.stub(:current_user){ create(:user) }
      create(:japanese, translation:translation)
      render translation
    end

    it{ should_not have_selector 'div#languages' }

    describe 'div.translation' do
      subject{ Capybara.string(rendered).find('div.translation')}
      it{ should have_selector "form#edit_translation_#{translation.id}" }
    end
  end #member logged in
end
