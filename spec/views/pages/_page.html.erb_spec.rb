require 'spec_helper'

describe 'pages_page.html.erb' do
  let(:page){ mock_model Page, project:nil }
  let(:presenter){ stub.as_null_object }
  before do
    view.should_receive(:present).and_yield presenter
  end

  it "renders a thumb image" do
    presenter.should_receive(:image).once.with(:thumb)
    render 'pages/page', page:page
  end

  it "renders a less than arrow" do
    presenter.should_receive(:decrease_pos).once
    render 'pages/page', page:page
  end

  it "renders the pos" do
    presenter.should_receive(:pos).once
    render 'pages/page', page:page
  end

  it "renders a greater than arrow" do
    presenter.should_receive(:increase_pos).once
    render 'pages/page', page:page
  end
end
