require 'spec_helper'

describe 'pages/show.html.erb' do
  let(:translation){ create(:translation)}
  before do
    assign(:translation, translation)
    assign(:page, translation.page)
    assign(:project, translation.project)
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
