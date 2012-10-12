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

      it "has no new translation form" do
        page.should_not have_form(:new_translation)
      end

      it "has no edit link" do
        div(:title).should_not have_link 'Edit'
      end
      it "has no new translation link" do
        bottom_links.should_not have_link 'New Translation'
      end

    end #without translations

    context "with translations" do
      before(:each) do 
        create_translation(@page.id,'mahou','magic')
        visit project_page_path(@project, @page)
      end

      it "has a translations section" do
        page.should have_div(:translations)
      end
      it "has a form for each translation" do
        div(:translations).forms_no(:translation).should be 1
      end
      it "the form has no edit button" do
        form(:edit_translation,0).should_not have_button('Update Translation')
      end
      #it "shows the japanese translation" do
      #  div(:translation_pair,0).div(:original).should have_content('mahou')
      #end
      #it "shows the english translation" do
      #  div(:translation_pair,0).div(:translation).should have_content('magic')
      #end
    end #with translations
  end #not logged in

  context "logged in as member" do
    before(:each){ signin }

    context "without translations" do
      before(:each) do 
        visit project_page_path(@project, @page)
      end

      it "has a new translation link" do
        bottom_links.should have_link 'New Translation'
      end

      it "has an edit link" do
        div(:title).should have_link 'Edit'
      end
      context "follow edit link" do
        before(:each) do
          div(:title).click_link 'Edit'
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
      #it "has x1 set to 100" do
      #  value(:translation_x1).should eq '100'
      #end
      #it "has y1 set to 100" do
      #  value(:translation_y1).should eq '100'
      #end
      #it "has x2 set to 400" do
      #  value(:translation_x2).should eq '400'
      #end
      #it "has y2 set to 400" do
      #  value(:translation_y2).should eq '400'
      #end
      
      it "has a create translation button" do
        form(:new_translation).should have_submit_button 'Create Translation'
      end
    end #without translations

    context "with translations" do
      before(:each) do 
        create_translation(@page.id,'mahou','magic')
        visit project_page_path(@project, @page)
      end

      it "the form has an edit button" do
        form(:translation,0).should have_button('Update Translation')
      end
    end #with translations
  end #logged in as member

end
