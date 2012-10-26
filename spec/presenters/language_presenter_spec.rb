require 'spec_helper'

describe LanguagePresenter do
  let(:language){ create(:english) }

  describe "#sentences" do
    context "without sentences" do
      let(:presenter){ LanguagePresenter.new(language, view) }
      it{ presenter.sentences.should be_nil }
    end

    context "with sentences" do
      before do
        create(:sentence, language:language, content:'<script>alert("you are hacked")</script>')
        create(:sentence, language:language)
      end

      context "user not logged in" do
        before{ controller.stub(:current_user){ nil }}
        let(:presenter){ LanguagePresenter.new(language, view) }
        it{ presenter.sentences.should be_nil }
      end

      context "member logged in" do
        before{ controller.stub(:current_user){ create(:user)}}
        let(:presenter){ LanguagePresenter.new(language, view) }

        describe "div#sentences" do
          subject{ Capybara.string(presenter.sentences).find('div#sentences') }
          it{ should have_selector('div.sentence', count:2)}
          it{ should have_content('<script>alert("you are hacked")</script>') }
        end
      end
    end
  end # #sentences

  describe "#history" do
    context "without sentences" do
      let(:presenter){ LanguagePresenter.new(language, view) }
      it{ presenter.history.should be_nil }
    end 
  end

  #describe "#history" do
  #  context "without sentences" do
  #    let(:presenter){ LanguagePresenter.new(language, view) }
  #  end
  #end
end
