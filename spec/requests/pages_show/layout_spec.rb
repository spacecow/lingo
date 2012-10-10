require 'spec_helper'

describe 'Pages show, layout' do
  before(:each) do
    @project = FactoryGirl.create(:project,title:'Ashita no Joe')
    @page = FactoryGirl.create(:page, project_id:@project.id)
  end

  context "not logged in" do
    context "without translations" do
      before(:each) do 
        visit project_page_path(@project, @page)
      end

      it "has a title" do
        page.should have_title('Ashita no Joe')
      end
      it "has a subtitle" do
        page.should have_subtitle('Page 1')
      end

      it "has no translations section" do
        page.should_not have_div(:translations)
      end

      it "has no new section form" do
        page.should_not have_form(:new_translation)
      end
    end
  end

  context "logged in as member" do
    before(:each){ signin }

    context "without translations" do
      before(:each) do 
        visit project_page_path(@project, @page)
      end

      it "has an edit link" do
        bottom_links.should have_link 'Edit'
      end
      context "follow edit link" do
        before(:each) do
          bottom_links.click_link 'Edit'
        end

        it "directs to the edit page page" do
          current_path.should eq edit_project_page_path(@project,@page)
        end
      end

      it "has a new section form" do
        page.should have_form(:new_translation)
      end

      it "has the japanese value set to nil" do
        value(:translation_languages_attributes_1_content).should be_empty
      end
      it "has the english value set to nil" do
        value(:translation_languages_attributes_0_content).should be_empty
      end
      
      it "has a create translation button" do
        form(:new_translation).should have_submit_button 'Create Translation'
      end
    end
  end

  context "with translations" do
    before(:each) do 
      create_translation(@page.id,'magic','mahou')
      visit project_page_path(@project, @page)
    end

    it "has a translations section" do
      page.should have_div(:translations)
    end
    it "has a div for each translation" do
      div(:translations).divs_no(:translation).should be 1
    end
    it "shows the english translation" do
      div(:translation,0).div(:english).should have_content('magic')
    end
    it "shows the japanese translation" do
      div(:translation,0).div(:japanese).should have_content('mahou')
    end
  end
end
