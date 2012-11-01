require 'spec_helper'

describe Noticement do
  it{ lambda{ Noticement.create!
  }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: User can't be blank, Notification can't be blank")}

  describe "create" do
    let!(:user){ create(:user)} #add one more user so that a noticement will be created 
    before do
      create(:sentence)
      assert_equal(User.count,2)
      assert_equal(Notification.count,1)
      assert_equal(Noticement.count,1)
    end
    it do end
    subject{ Noticement.last }
    its(:notification_id){ should be Notification.last.id }
    its(:user_id){ should be user.id }
    its(:active){ should be true }
  end
end
