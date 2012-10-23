require 'spec_helper'

describe 'sentences/comments.html.erb' do
  let(:sentence){ create(:sentence) }
  before do
    present sentence do |presenter|
      @presenter = presenter
    end
  end

  context 'without comments' do
    before{ render 'sentences/comments', presenter:@presenter }
    subject{ Capybara.string(rendered) }
    it{ should_not have_selector 'div#comments' }
  end

  context 'with comments' do
    before do
      create(:comment, commentable:sentence)
      render 'sentences/comments', presenter:@presenter
    end

    subject{ Capybara.string(rendered) }
    it{ should have_selector 'div#comments' }

    describe 'div#comments' do
      subject{ Capybara.string(rendered).find('div#comments') }
      it{ should have_selector 'div.comment', count:1 }
    end
  end
end
