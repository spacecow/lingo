require 'spec_helper'

describe 'Pages show, create section' do
  before(:each) do
    signin
    project = FactoryGirl.create(:project)
    @page = FactoryGirl.create(:page, project_id:project.id)
    visit project_page_path(project, @page)
    fill_in 'translation_languages_attributes_0_content', with:'nihongo'
    fill_in 'translation_languages_attributes_1_content', with:'japanese'
  end

  it "saves the translation to db" do
    lambda do click_button 'Create Translation'
    end.should change(Translation,:count).by(1)
  end
  it "saves the languages to db" do
    lambda do click_button 'Create Translation'
    end.should change(Language,:count).by(2)
  end

  context "saves" do
    before(:each) do
      click_button 'Create Translation'
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

    context "error" do
      it "both languages cannot be left blank"
    end
  end
end
