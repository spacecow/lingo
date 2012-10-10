require 'spec_helper'

describe 'Projects new, layout' do
  before(:each) do
    signin
    visit new_project_path
  end

  it "has a title" do
    page.should have_title('New Project')
  end

  it "has a new project form" do
    page.should have_form(:new_project)
  end

  it "has the title value set to blank" do
    value('* Title').should be_nil
  end

  it "has a create project button" do
    page.should have_submit_button('Create Project') 
  end

  context "create" do
    before(:each) do
      fill_in 'Title', with:'Ashita no Joe'
    end

    it "saves project to db" do
      lambda do click_button 'Create Project'
      end.should change(Project,:count).by(1)
    end

    context "saves" do
      before(:each) do
        click_button 'Create Project'
        @project = Project.last
      end

      it "title" do
        @project.title.should eq 'Ashita no Joe' 
      end

      it "shows a flash message" do
        page.should have_notice('Project created')
      end
    end

    context "error" do
      it "title cannot be left blank" do
        fill_in 'Title', with:''
        click_button 'Create Project'
        div(:title).should have_blank_error  
      end

      it "title cannot be duplicated" do
        FactoryGirl.create(:project,title:'Ashita no Joe')
        click_button 'Create Project'
        div(:title).should have_duplication_error  
      end
    end
  end
end
