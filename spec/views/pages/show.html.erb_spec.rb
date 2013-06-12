require 'spec_helper'

describe 'pages/show.html.erb' do
  let(:translation){ stub_model Translation }
  let(:project){ mock_model Project, title:'Joe' }
  let(:page){ stub_model Page }
  before do
    assign(:translation, translation)
    assign(:page, page)
    assign(:project, project)
  end

  context 'no user logged in' do
    before do
      controller.stub(:current_user){ nil }
      view.stub(:current_user){ nil }
      render
    end

    subject{ Capybara.string(rendered)}
    it{ should_not have_selector 'div.noticements_container' }
  end
end
