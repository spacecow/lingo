require 'spec_helper'

describe PagePresenter do
  let(:page){ mock_model Page }
  let(:presenter){ PagePresenter.new(page, view) }
  let(:rendering){ Capybara.string function }

  describe "current_pos" do
    let(:function){ presenter.current_pos }
    before{ page.should_receive(:pos).and_return 1 }
    subject{ rendering }

    its(:text){ should eq 'Page 1' }
  end

  describe "decrease_pos" do
    let(:function){ presenter.decrease_pos }
    subject{ rendering.find 'a' }

    its(:text){ should eq '<' }
    specify{ subject[:href].should eq decrease_pos_path(page_id:page.id) }
    specify{ subject['data-method'].should eq 'put' }
  end

  describe "increase_pos" do
    let(:function){ presenter.increase_pos }
    subject{ rendering.find 'a' }

    its(:text){ should eq '>' }
    specify{ subject[:href].should eq increase_pos_path(page_id:page.id) }
    specify{ subject['data-method'].should eq 'put' }
  end

  describe "next_pos" do
    let(:function){ presenter.next_pos }
    
    context "there is a next page," do
      let(:next_page){ create :page, pos:20 }
      before{ page.should_receive(:next_page).and_return next_page }
      subject{ rendering.find 'a' }

      its(:text){ should eq 'Page 20 >' }
      specify{ subject[:href].should eq project_page_path(next_page.project, next_page) }
    end

    context "there is no next page," do
      before{ page.should_receive(:next_page).and_return nil }
      subject{ rendering }
      its(:text){ should be_empty }
    end
  end

  describe "previous_pos" do
    let(:function){ presenter.prev_pos }

    context "there is a previous page" do
      let(:prev_page){ create :page, pos:0 }
      before{ page.should_receive(:prev_page).and_return prev_page }
      subject{ rendering.find 'a' }

      its(:text){ should eq '< Page 0' }
      specify{ subject[:href].should eq project_page_path(prev_page.project, prev_page) }
    end

    context "there is a previous page" do
      before{ page.should_receive(:prev_page).and_return nil }
      subject{ rendering }

      its(:text){ should be_empty }
    end
  end
end
