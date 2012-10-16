require 'spec_helper'

describe Translation do
  let(:translation){ create(:translation) }
  let(:user){ create(:user) }
  before{ create(:japanese,user:user,translation:translation) }

  it "a user can only have one language for each translation" do
    lambda{ create(:japanese, user:user, translation:translation)
    }.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Translation has already been taken')
  end 

  it "a user can have a different language for a translation" do
    lambda{ create(:english, user:user, translation:translation)
    }.should change(Language,:count).by(1) 
  end 

  it "different users can have a language of the same type for the same translation" do
    lambda{ create(:japanese, user:create(:user), translation:translation)
    }.should change(Language,:count).by(1) 
  end 
end
