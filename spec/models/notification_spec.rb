require 'spec_helper'

describe Notification do
  let(:user){ create(:user) }

  it{ lambda{ Notification.create!
  }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Notifiable can't be blank, Creator can't be blank, Type mask can't be blank, Content can't be blank") } 
  
  describe "create sentence" do
    before{ 2.times{ create(:user) }}
    let!(:sentence){ create(:sentence, user:user, content:'yeah') }

    describe Notification do
      subject{ Notification.last }
      its(:notifiable_id){ should be sentence.id }
      its(:notifiable_type){ should eq "Sentence" }
      its(:creator_id){ should be user.id }
      its(:type_mask){ should eq Notification.type(:create) }
      its(:content){ should eq 'yeah' }
    end #create for sentence

    it{ Noticement.count.should be 2 }
  end

  describe "create comment" do
    before{ 2.times{ create(:user) }}
    let!(:comment){ create(:comment, user:user, content:'wow')}

    describe Notification do
      subject{ Notification.last }
      its(:notifiable_id){ should be comment.id }
      its(:notifiable_type){ should eq "Comment" }
      its(:creator_id){ should be user.id }
      its(:type_mask){ should eq Notification.type(:create) }
      its(:content){ should eq 'wow' }
    end

    it{ Noticement.count.should be 2 }
  end

  describe "update sentence" do
  end
end
