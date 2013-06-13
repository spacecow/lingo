require 'spec_helper'

describe 'projects/show.html.erb' do
  let(:project){ create :project, title:'Final Fantasy' }
  let!(:page){ create :page, pos:1, project_id:project.id }
  before do
    assign :project,project
    controller.stub(:current_user){ nil }
    render
  end

  it{ rendered.should have_selector 'h1', text:'Final Fantasy' }
  it{ rendered.should have_selector 'div.pages' }
end
