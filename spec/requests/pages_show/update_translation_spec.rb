require 'spec_helper'

describe 'Pages show, updates translation' do
  let(:_page){ create(:page) }
  before do
    signin
    @user = User.last
    translation = create(:translation, page:_page)
    create(:japanese, translation:translation, user:@user) 
    create(:english, translation:translation, user:create(:user)) 
    visit project_page_path(_page.project, _page)
    fill_in 'translation_languages_attributes_0_content', with:'nihongo'
    fill_in 'translation_languages_attributes_1_content', with:'japanese'
  end

  it "", focus:true do
    lambda do click_button 'Update Translation'
    end.should change(Translation,:count).by(0)
  end 

  #it "adds no translations to db" do
  #  lambda{ click_button 'Update Translation'
  #  }.should change(Translation,:count).by(0)
  #end
  #it "adds no languages to db" do
  #  lambda{ click_button 'Update Translation'
  #  }.should change(Language,:count).by(0)
  #end

  context "updates own translation" do
    before{ click_button 'Update Translation' }
    let(:translation){ Translation.last }

    subject(:japanese){ translation.languages.first }
    its(:content){ should eq 'nihongo' }
    its(:type){ should eq 'Japanese' }
    its(:translation_id){ should eq translation.id }
    its(:user_id){ should eq @user.id }
  end

  context "creates translation if none exist for user", focus:true do
    before{ click_button 'Update Translation' }
    let(:translation){ Translation.last }

    subject(:english){ translation.languages.last }
    its(:content){ should eq 'japanese' }
    its(:type){ should eq 'English' }
    its(:translation_id){ should eq translation.id }
    its(:user_id){ should eq @user.id }
  end
  #    @translation = Translation.last
  #    @japanese = @translation.languages.first
  #    @english = @translation.languages.last
  #  end

  #  it "parent page for translation" do
  #    @translation.page.should eq @page
  #  end
  #  it "content english" do
  #    @english.content.should eq 'japanese'
  #  end
  #  it "type english" do
  #    @english.type.should eq 'English'
  #  end
  #  it "parent translation for english" do
  #    @english.translation.should eq @translation
  #  end

  #  it "shows a flash message about the update" do
  #    page.should have_notice('Translation updated')
  #  end
  #  it "redirects back to the page" do
  #    current_path.should eq project_page_path(@page.project,@page)
  #  end
  #end #updates
end
