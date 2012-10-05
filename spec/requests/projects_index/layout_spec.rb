require 'spec_helper'

describe 'Projects index, layout' do
  before(:each) do
    visit projects_path
  end

  it "has a title" do
    page.should have_title('Projects')
  end
end
