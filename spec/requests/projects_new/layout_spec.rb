require 'spec_helper'

describe 'Projects new, layout' do
  before(:each) do
    visit new_project_path
  end

  it "has a title" do
    page.should have_title('New Project')
  end
end
