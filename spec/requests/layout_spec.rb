require 'spec_helper'

describe 'Site Layout, site nav', focus:true do
  context 'on the root page' do
    before(:each) do
      visit root_path
    end

    it "shows the projects index page" do
      site_nav.should have_content 'Projects'
    end
    it "shows the projects page as a link" do
      site_nav.should have_link 'Projects'
    end
  end

  context 'on a project show page' do
    before(:each) do
      project = FactoryGirl.create(:project)
      visit project_path(project)
    end

    it "shows the projects page" do
      site_nav.should have_content 'Projects'
    end
    it "shows the projects page as a link" do
      site_nav.should have_link 'Projects'
    end

    context "follow projects" do
      before(:each) do
        site_nav.click_link 'Projects'
      end

      it "directs to the project index page" do
        current_path.should eq projects_path
      end
    end
  end

  context "on a project's page page" do
    before(:each) do
      @project = FactoryGirl.create(:project, title:'Ashita no Joe')
      page = FactoryGirl.create(:page, project_id:@project.id)
      visit project_page_path(page.project,page)
    end

    it "shows the projects page" do
      site_nav.should have_content 'Projects > Ashita no Joe'
    end
    it "shows the projects page as a link" do
      site_nav.should have_link 'Projects'
    end
    it "shows the project page as a link" do
      site_nav.should have_link 'Ashita no Joe'
    end

    context "follow projects" do
      before(:each) do
        site_nav.click_link 'Projects'
      end

      it "directs to the project index page" do
        current_path.should eq projects_path
      end
    end

    context "follow Ashita no Joe" do
      before(:each) do
        site_nav.click_link 'Ashita no Joe'
      end

      it "directs to the project's show page" do
        current_path.should eq project_path(@project)
      end
    end
  end
end
