require 'spec_helper'

describe 'Pages edit, layout' do
  before(:each) do
    signin
    project = FactoryGirl.create(:project,title:'Ashita no Joe')
    @page = FactoryGirl.create(:page, project_id:project.id, no:123)
    visit edit_project_page_path(project,@page)
  end

  it "has a title" do
    page.should have_title('Edit Page for Ashita no Joe')
  end

  it "has a edit page form" do
    page.should have_form("edit_page_#{@page.id}")
  end
  it "has the no value set" do
    value('* No').should eq "123"
  end
  it "has the image value set to blank" do
    value('Image').should be_nil
  end
end
