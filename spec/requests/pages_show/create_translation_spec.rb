require 'spec_helper'

describe 'Pages show, create translation' do
  before(:each) do
    @page = FactoryGirl.create(:page)
    signin
    visit project_page_path(@page.project, @page)
    fill_in 'translation_languages_attributes_0_content', with:'nihongo'
    fill_in 'translation_languages_attributes_1_content', with:'japanese'
  end
  let(:user){ User.last }

  it "saves the translation to db" do
    lambda do click_button 'Create Translation'
    end.should change(Translation,:count).by(1)
  end
  it "saves the languages to db" do
    lambda do click_button 'Create Translation'
    end.should change(Language,:count).by(2)
  end

  context "saves" do
    before{ click_button 'Create Translation' }
    let(:translation){ Translation.last }
    let(:japanese){ translation.languages.first }
    let(:english){ translation.languages.last }

    it{ translation.page.should eq @page }
    it{ japanese.content.should eq 'nihongo' }
    it{ japanese.type.should eq 'Japanese' }
    it{ japanese.translation.should eq translation }
    it{ japanese.user.should eq user }
    it{ english.content.should eq 'japanese' }
    it{ english.type.should eq 'English' }
    it{ english.translation.should eq translation }
    it{ english.user.should eq user }

    it{ page.should have_notice('Translation created') }
    it{ current_path.should eq project_page_path(@page.project,@page) }

    context "error" do
      it "both languages cannot be left blank"
    end #error
  end #saves
end
