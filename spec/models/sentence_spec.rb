require 'spec_helper'

describe Sentence do
  let(:language){ create(:japanese) }
  let(:user){ create(:user) }
  before{ create(:sentence, user:user, language:language) }

  it "a user can only have one sentence for each language" do
    lambda{ create(:sentence, user:user, language:language)
    }.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Language has already been taken')
  end 

  it "a user can have different sentences for different languages" do
    lambda{ create(:sentence, user:user, language:create(:japanese))
    }.should change(Sentence,:count).by(1)
  end

  it "different users can have sentences for a languages" do
    lambda{ create(:sentence, user:create(:user), language:language)
    }.should change(Sentence,:count).by(1)
  end
end
