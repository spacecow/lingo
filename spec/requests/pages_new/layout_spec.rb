require 'spec_helper'

describe 'Pages new, layout' do
  before(:each) do
    @project = FactoryGirl.create(:project,title:'Ashita no Joe')
    visit new_project_page_path(@project)
  end

  it "has a title" do
    page.should have_title('New Page for Ashita no Joe')
  end

  it "has a new project form" do
    page.should have_form(:new_page)
  end

  it "has the title value set to blank" do
    value('* No').should be_nil
  end

  it "has a create page button" do
    page.should have_submit_button('Create Page') 
  end

  context "create" do
    before(:each) do
      fill_in 'No', with:2
    end

    it "saves project to db" do
      lambda do click_button 'Create Page'
      end.should change(Page,:count).by(1)
    end

    context "saves" do
      before(:each) do
        click_button 'Create Page'
        @page = Page.last
      end

      it "title" do
        @page.no.should be 2 
      end
      it "project_id" do
        @page.project_id.should be @project.id
      end

      it "shows a flash message" do
        page.should have_notice('Page created')
      end
    end

    context "error" do
      it "no cannot be blank" do
        fill_in 'No', with:''
        click_button 'Create Page'
        div(:no).should have_blank_error  
      end
    end
  end
end
