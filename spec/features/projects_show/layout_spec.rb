require 'spec_helper'

describe 'Projects show, layout' do
  before(:each) do
    @project = FactoryGirl.create(:project)
  end

  context "not logged in" do
    context "without pages" do
      before(:each) do
        visit project_path(@project)
      end

      it "has the project as the title" do
        page.should have_selector 'h1', text:@project.title
      end

      it "has no div with pages" do
        page.should_not have_div(:pages)
      end

      it "has no new page link" do
        bottom_links.should_not have_link 'New Page'
      end
    end

    context "with pages" do
      before(:each) do
        FactoryGirl.create(:page, project_id:@project.id)
        visit project_path(@project)
      end

      it "has a div with pages" do
        page.should have_selector('div.pages')
      end
      it "has a div for each page" do
        find('div.pages').divs_no(:thumb).should be 1
      end
    end
  end

  context "logged in as member" do
    before(:each) do
      signin
      visit project_path(@project)
    end

    it "has a new page link" do
      bottom_links.should have_link 'New Page'
    end

    context "follow new page link" do
      before(:each) do
        bottom_links.click_link 'New Page'
      end

      it "directs to the new page page" do
        current_path.should eq new_project_page_path(@project)
      end
    end
  end
end
