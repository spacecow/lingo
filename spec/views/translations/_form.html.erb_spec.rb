require 'spec_helper'

describe 'translations/form.html.erb' do
  let(:translation){ create(:translation) }
  before{ present [translation, translation.page, translation.project] do |p| @p = p end }

  describe "form#edit_translation_x" do
    let(:language){ create(:japanese, translation:translation)}
    let!(:sentence){ create(:sentence, language:language)}

    context "non active" do
      before{ render 'translations/form', active:false, presenter:@p}
      subject{ Capybara.string(rendered)}
      it{ should have_selector 'textarea' }
      it{ should_not have_selector 'textarea.active' }
    end

    context "active" do
      before do
        assign(:active_id, sentence.id)
        render 'translations/form', active:false, presenter:@p
      end
      subject{ Capybara.string(rendered)}
      it{ should have_selector 'textarea.active' }
    end
  end

  describe "form#new_translation" do
    before do
      render 'translations/form', active:true, presenter:@p
    end   

    subject{ Capybara.string(rendered).find("form#edit_translation_#{translation.id}")}
    it{ should have_selector 'a#comment', text:'Comment' }
  end
end
