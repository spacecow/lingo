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
    first(:field,'comment_content').set 'Just a comment'
  end

  it do
    lambda{ first(:button,'Create Comment').click }.should change(Comment,:count).by(1)
  end
  it do
    lambda{ first(:button,'Create Comment').click }.should change(Notification,:count).by(1)
  end
  it "saves noticements to other users about the created comment" do
    # 3 users, 1 of them creates the comment.
    # That user is not notified
    lambda{ first(:button,'Create Comment').click }.should change(Noticement,:count).by(2)
  end

  context "saved comment" do
    before{ first(:button,'Create Comment').click }
    subject{ Comment.last } 
    its(:commentable_id){ should eq sentence.id }
    it{ page.should have_notice('Comment created') }
  end

  context "error" do
    before do
      first(:field,'comment_content').set ''
      first(:button,'Create Comment').click
    end
    it{ page.should have_alert('Comment cannot be blank') }
  end
  #  it{ current_path.should eq project_page_path(_page.project, _page) }
end
