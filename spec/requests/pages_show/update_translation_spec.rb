require 'spec_helper'

describe 'Pages show, update translation' do
  before(:each) do
    @page = FactoryGirl.create(:page)
    create_translation(@page.id,'mahou','magic')
    signin
    visit project_page_path(@page.project, @page)
    fill_in 'translation_languages_attributes_0_content', with:'nihongo'
    fill_in 'translation_languages_attributes_1_content', with:'japanese'
  end

  it "adds no translations to db" do
    lambda{ click_button 'Update Translation'
    }.should change(Translation,:count).by(0)
  end
  it "adds no languages to db" do
    lambda{ click_button 'Update Translation'
    }.should change(Language,:count).by(0)
  end

  context "updates" do
    before(:each) do
      click_button 'Update Translation'
      @translation = Translation.last
      @japanese = @translation.languages.first
      @english = @translation.languages.last
    end

    it "parent page for translation" do
      @translation.page.should eq @page
    end
    it "content japanese" do
      @japanese.content.should eq 'nihongo'
    end
    it "type japanese" do
      @japanese.type.should eq 'Japanese'
    end
    it "parent translation for japanese" do
      @japanese.translation.should eq @translation
    end
    it "content english" do
      @english.content.should eq 'japanese'
    end
    it "type english" do
      @english.type.should eq 'English'
    end
    it "parent translation for english" do
      @english.translation.should eq @translation
    end

    it "shows a flash message about the update" do
      page.should have_notice('Translation updated')
    end
    it "redirects back to the page" do
      current_path.should eq project_page_path(@page.project,@page)
    end
  end #updates
end
