require 'spec_helper'

describe PagePresenter do
  let(:page){ mock_model Page }
  let(:presenter){ PagePresenter.new(page, view) }
  let(:rendered){ Capybara.string function }
  subject{ rendered }

  describe "decrease_pos" do
    let(:function){ presenter.decrease_pos }
    its(:text){ should eq '<' } 

    describe 'link' do
      subject{ rendered.find 'a' }
      its(:text){ should eq '<' }
      specify{ subject[:href].should eq decrease_pos_path(page_id:page.id) }
      specify{ subject['data-method'].should eq 'put' }
    end
  end

  describe "increase_pos" do
    let(:function){ presenter.increase_pos }
    its(:text){ should eq '>' } 

    describe 'link' do
      subject{ rendered.find 'a' }
      its(:text){ should eq '>' }
      specify{ subject[:href].should eq increase_pos_path(page_id:page.id) }
      specify{ subject['data-method'].should eq 'put' }
    end
  end
end
