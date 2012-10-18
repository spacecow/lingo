require 'spec_helper'

describe Language do
  describe "#destroy" do
    context "with sentences" do
      let!(:sentence){ create(:sentence) }
      it do
        lambda{ sentence.language.destroy
        }.should change(Sentence,:count).by(-1) 
      end
    end
  end
end
