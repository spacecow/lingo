require 'spec_helper'

describe Sentence do
  let(:language){ create(:japanese) }
  let(:user){ create(:user) }
  let!(:sentence){ create(:sentence, user:user, language:language) }

  context "create" do
    it "a user can only have one sentence for each language" do
      lambda{ create(:sentence, user:user, language:language)
      }.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Language has already been taken')
    end 

    it "a user can have different sentences for different languages" do
      lambda{ create(:sentence, user:user, language:create(:japanese))
      }.should change(Sentence,:count).by(1)
    end

    it "different users can have sentences for the same language" do
      lambda{ create(:sentence, user:create(:user), language:language)
      }.should change(Sentence,:count).by(1)
    end
  end

  context "update" do
    let(:update){ lambda{ sentence.update_attributes(content:'new context')}}

    it "saves a notification to db" do
      update.should change(Notification,:count).by(1)
    end
    it "saves noticements to other users to db" do
      create(:user) #2 users
      update.should change(Noticement,:count).by(1)
    end

    context "values" do
      before{ update.call }
      subject{ Notification.last }
      its(:content){ should eq 'new context' }
      its(:type_mask){ should be 2 }
    end
  end
end
