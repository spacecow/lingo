require 'spec_helper'

describe 'Pages show, layout' do
  before(:each) do
    project = FactoryGirl.create(:project,title:'Ashita no Joe')
    page = FactoryGirl.create(:page, project_id:project.id)
    visit project_page_path(project, page)
  end

  it "has a title" do
    page.should have_title('Ashita no Joe')
  end
  it "has a subtitle" do
    page.should have_subtitle('Page 1')
  end
end
