require 'spec_helper'

describe TranslationPresenter do
  let(:translation){ create(:translation) }

  describe '#noticements' do
    let(:presenter){ TranslationPresenter.new(translation, view)}
    context "no user logged in" do
      let(:member){ nil }
      before{ controller.stub(:current_user){ member }}
      it{ presenter.noticements(member).should be_nil }
    end

    context "member logged in" do
      let!(:member){ create(:user)}
      before{ controller.stub(:current_user){ member }}
      
      context "without noticements" do
        it{ presenter.noticements(member).should be_nil }
      end

      context "with noticements" do
        before{ create(:sentence, content:'noticement!') }
        subject{ Capybara.string(presenter.noticements(member)) }
        it{ should have_selector 'div.noticements' }

        describe 'div.noticements' do
          subject{ Capybara.string(presenter.noticements(member)).find('div.noticements')}
          it{ should have_selector 'div.noticement', count:1 }

          describe 'div.noticement' do
            subject{ Capybara.string(presenter.noticements(member)).find('div.noticements div.noticement')}
            it{ should have_content 'noticement!' }
          end
        end
      end
    end
  end

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
