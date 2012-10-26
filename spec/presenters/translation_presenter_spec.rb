require 'spec_helper'

describe TranslationPresenter do
  let(:translation){ create(:translation) }

  describe "#histories" do
    context "without languages" do
      let(:presenter){ TranslationPresenter.new(translation, view)}
      it{ presenter.histories.should be_nil }
    end

    context "with languages" do
      let(:language){ create(:japanese, translation:translation)}
      let(:presenter){ TranslationPresenter.new(translation, view)}

      describe "div#histories" do
        subject{ Capybara.string(presenter.histories).find('div#histories') }
        it{ should have_selector("div.history#history_#{language.id}", count:1)}
      end
    end
  end
end
