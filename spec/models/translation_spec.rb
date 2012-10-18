require 'spec_helper'

describe Translation do
  describe "#destroy" do
    context "with languages" do
      let!(:language){ create(:japanese) }
      it do
        lambda{ language.translation.destroy
        }.should change(Language,:count).by(-1) 
      end
    end
  end
end
