require 'spec_helper'

describe Noticement do
  let(:notification){ create(:notification) }
  let(:user){ create(:user) }

  it{ lambda{ Noticement.create!
  }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: User can't be blank, Notification can't be blank")}

  describe "create" do
    before{ Noticement.notice_to!(notification,user)}
    subject{ Noticement.last }
    its(:notification_id){ should be notification.id }
    its(:user_id){ should be user.id }
    its(:active){ should be true }
  end
end
