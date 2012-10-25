require 'spec_helper'

describe 'translations/languages.html.erb' do
  let(:translation){ create(:translation) }
  before do
    create(:japanese, translation:translation)
    present translation do |p| @p = p end
    render 'translations/languages', presenter:@p
  end

  describe 'div#languages' do
    subject{ Capybara.string(rendered).find('div#languages')}
    it{ should have_selector 'div.language', count:1 }
  end
end
