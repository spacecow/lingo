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
    fill_in 'comment_content', with:'Just a comment'
  end

  it do
    lambda{ div(:history,0).click_button 'Create Comment'}.should change(Comment,:count).by(1)
  end

  context "saved comment" do
    before{ div(:history,0).click_button 'Create Comment' }
    subject{ Comment.last } 
    its(:commentable_id){ should eq sentence.id }
    it{ page.should have_notice('Comment created') }
  end

  context "error" do
    before do
      fill_in 'comment_content', with:''
      div(:history,0).click_button 'Create Comment'
    end
    it{ page.should have_alert('Comment cannot be blank') }
  end
  #  it{ current_path.should eq project_page_path(_page.project, _page) }
end
