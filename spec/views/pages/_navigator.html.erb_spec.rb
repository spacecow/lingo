require 'spec_helper'

describe 'pages/_navigator.html.erb' do
  let(:page){ mock_model Page }
  let(:presenter){ stub.as_null_object }
  let(:rendering){ render 'pages/navigator', page:page }
  before{ view.should_receive(:present).and_yield presenter }

  it "renders the previous page no" do
    presenter.should_receive(:prev_pos).once
  end
  it "renders the current page no" do
    presenter.should_receive(:current_pos).once
  end
  it "renders the next page no" do
    presenter.should_receive(:next_pos).once
  end

  after{ rendering }
end
