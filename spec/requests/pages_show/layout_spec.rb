require 'spec_helper'

describe 'Pages show, layout' do
  before(:each) do
    project = FactoryGirl.create(:project,title:'Ashita no Joe')
    @page = FactoryGirl.create(:page, project_id:project.id)
    visit project_page_path(project, @page)
  end

  it "has a title" do
    page.should have_title('Ashita no Joe')
  end
  it "has a subtitle" do
    page.should have_subtitle('Page 1')
  end

  it "has a new section form" do
    page.should have_form(:new_translation)
  end

  it "has the japanese value set to nil" do
    value('Japanese').should be_nil
  end
  it "has the english value set to nil" do
    value('English').should be_nil
  end
  it "has the page_id value set" do
    value('Page').should eq @page.id.to_s
  end
end
