require 'spec_helper'

describe 'Pages show, layout' do
  let(:_page){ create(:page) }

  context "member logged in" do
    before{ signin }

    context "with translations" do
      let(:translation){ create(:translation, page:_page) }
      let(:japanese){ create(:japanese, translation:translation) }
      let(:english){ create(:english, translation:translation) }
      let!(:jap_sentence){ create(:sentence, language:japanese) }
      let!(:eng_sentence){ create(:sentence, language:english) }
  
      context "without history" do
        before{ visit project_page_path(_page.project, _page) }
        it "displays no history if nothing is in it" do
          form.should_not have_selector 'div.history'
        end
      end

      context "with history" do
        before do
          create(:sentence, language:japanese)
          visit project_page_path(_page.project, _page)
        end
        it "displays sentences if there are more than 1" do
          div(:history,0).divs_no(:sentence).should be 2 
        end
        it "displays comments form if there are more than 1" do
          div(:history,0).forms_no(:new_comment).should be 2 
        end
        it "displays none if there is just one" do
          form.should_not have_selector 'div.history'
          #div(:history,1).divs_no(:sentence).should be 0 
        end 
      end
    end
  end #member logged in
end

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

      it { page.should have_title('Ashita no Joe') }
      it { page.should have_subtitle('Page 1') }
      it { page.should_not have_div(:translations) }
      it { page.should_not have_form(:new_translation) }
      it { div(:title).should_not have_link 'Edit' }
      it { bottom_links.should_not have_link 'New Translation' }

    end #without translations

    context "with translations" do
      context "without version" do
        before(:each) do 
          create_translation(@page.id,'mahou','magic')
          visit project_page_path(@project, @page)
        end

        it { page.should have_div(:translations) }
        it { div(:translations).should have_div(:languages) }
        it { form(:edit_translation,0).should_not have_button('Update Translation') }
      end #without version (with translations)

      context "with other version" do
        before(:each) do
          translation = create_translation(@page.id,'mahou','magic')
          translation.languages << Japanese.new
        end

        it "" do
        end
      end #with other version (with translations)
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
        value(:translation_languages_attributes_1_popular_sentence_attributes_content).should be_empty
      end
      it "has the english value set to nil" do
        value(:translation_languages_attributes_0_popular_sentence_attributes_content).should be_empty
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
