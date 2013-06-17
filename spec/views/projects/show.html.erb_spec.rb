require 'spec_helper'

describe 'projects/show.html.erb' do
  let(:project){ mock_model Project }
  let(:presenter){ stub.as_null_object }

  before do
    assign :project,project
    view.should_receive(:present).and_yield presenter
  end

  it "has the project's title" do
    project.should_receive(:title).once.and_return 'Final Fantasy'
    render
    rendered.should have_selector 'h1', text:'Final Fantasy'
  end

  it "presents the project's pages" do
    presenter.should_receive(:pages).once
    render
  end

  it "presents a new project link" do
    presenter.should_receive(:new_page_link).once
    render
  end
end
