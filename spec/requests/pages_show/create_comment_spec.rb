require 'spec_helper'

describe 'Pages show, create comment' do
  let(:_page){ create(:page) }
  let(:translation){ create(:translation, page:_page) }
  let(:japanese){ create(:japanese, translation:translation) }
  let!(:sentence){ create(:sentence, language:japanese) } #1 user
  before do
    signin #1 user
    create(:sentence, language:japanese) #1 user
    visit project_page_path(_page.project, _page)
    fill_in 'comment_content', with:'Just a comment'
  end

  it do
    lambda{ div(:history,0).click_button 'Create Comment'}.should change(Comment,:count).by(1)
  end
  it do
    lambda{ div(:history,0).click_button 'Create Comment'}.should change(Notification,:count).by(1)
  end
  it "saves noticements to other users about the created comment" do
    # 3 users, 1 of them creates the comment.
    # That user is not notified
    lambda{ div(:history,0).click_button 'Create Comment'}.should change(Noticement,:count).by(2)
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
