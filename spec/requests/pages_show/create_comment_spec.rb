require 'spec_helper'

describe 'Pages show, create comment' do
  let(:_page){ create(:page) }
  let(:translation){ create(:translation, page:_page) }
  let(:japanese){ create(:japanese, translation:translation) }
  let!(:sentence){ create(:sentence, language:japanese) }
  before do
    signin
    create(:sentence, language:japanese)
    visit project_page_path(_page.project, _page)
  end

  it do
    lambda{ div(:history,0).click_button 'Create Comment'}.should change(Comment,:count).by(1)
  end

  context "saved comment" do
    before{ div(:history,0).click_button 'Create Comment' }
    subject{ Comment.last } 
    its(:commentable_id){ should eq sentence.id }
  end
  #  it{ current_path.should eq project_page_path(_page.project, _page) }
end
