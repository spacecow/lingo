require 'spec_helper'

describe 'Pages edit, layout' do
  before(:each) do
    signin
    @project = FactoryGirl.create(:project,title:'Ashita no Joe')
    @page = FactoryGirl.create(:page, project_id:@project.id, no:123)
    visit edit_project_page_path(@project,@page)
    fill_in 'No', with:'666'
  end

  context "update" do
    it "saves no new page to db" do
      lambda do click_button 'Update Page'
      end.should change(Page,:count).by(0)
    end

    context "saves" do
      before(:each) do
        click_button 'Update Page'
        @page = Page.last
      end

      it "no" do
        @page.no.should be 666 
      end
      it "project_id" do
        @page.project_id.should be @project.id
      end

      it "shows a flash message" do
        page.should have_notice('Page updated')
      end
      it "redirects back to the page page" do
        current_path.should eq project_page_path(@project,@page)
      end
    end
  end
end
