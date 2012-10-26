require 'spec_helper'

describe 'translations/form.html.erb' do
  let(:translation){ create(:translation) }
  before do
    present [translation, translation.page, translation.project] do |p| @p = p end
    render 'translations/form', active:true, presenter:@p
  end   

  describe "form#new_translation" do
    subject{ Capybara.string(rendered).find("form#edit_translation_#{translation.id}")}
    it{ should have_selector 'a#comment', text:'Comment' }
  end
end
