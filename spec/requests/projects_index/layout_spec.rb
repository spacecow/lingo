require 'spec_helper'

describe 'Projects index, layout' do
  context "without projects" do
    context "not logged in" do
      before(:each) do
        visit projects_path
      end

      it "has a title" do
        page.should have_title('Projects')
      end

      it "has no div for the projects" do
        page.should_not have_div(:projects)
      end

      it "has no link to a new project" do
        bottom_links.should_not have_link('New Project')
      end
    end

    context "logged in as member" do
      before(:each) do
        signin
        visit projects_path
      end

      it "has a link to a new project" do
        bottom_links.should have_link('New Project')
      end

      context "new project link" do
        before(:each) do
          bottom_links.click_link 'New Project'
        end

        it "directs to the new project page" do
          current_path.should eq new_project_path
        end
      end
    end
  end

  context "with projects" do
    before(:each) do
      @project = FactoryGirl.create(:project, title:'Ashita no Joe')
    end

    context "not logged in" do
      before(:each) do
        visit projects_path
      end

      it "has a div for the projects" do
        page.should have_div(:projects)
      end
      it "has a div for each project" do
        div(:projects).divs_no(:project).should be 1
      end
      it "has the project name displayed as a link" do
        div(:project,0).should have_link 'Ashita no Joe'
      end
      context "click project's name" do
        before(:each) do
          div(:project,0).click_link 'Ashita no Joe'
        end

        it "directs to that project show page" do
          current_path.should eq project_path(@project)
        end
      end
    end
  end
end
