require 'spec_helper'

describe ProjectPresenter do
  let(:project){ mock_model Project }
  let(:presenter){ ProjectPresenter.new(project,view) }
  let(:rendering){ Capybara.string function }

  describe "pages" do
    let(:function){ presenter.pages }
    let(:page){ stub_model Page }
    before do
      project.should_receive(:first_page).and_return page
      presenter.should_receive(:render_pages).with(page).and_return "first page"
    end

    it "renders the pages with start at the first page" do
      rendering.find('div.pages').text.should eq "first page"
    end
  end
end
