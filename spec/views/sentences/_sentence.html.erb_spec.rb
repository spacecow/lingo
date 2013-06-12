require 'spec_helper'

describe 'sentences/sentence.html.erb' do
  let(:user){ create(:user, username:'Batman') }
  let(:sentence){ create(:sentence, user:user, content:'bajs', updated_at:1.hour.ago) }

  context "not logged in" do
    before{ controller.stub(:current_user){ nil }}
      context "without comments" do
        before{ render sentence, comment:Comment.new }

        subject{ Capybara.string(rendered) } 
        it{ should have_selector 'div#content', text:'bajs' }
        it{ should_not have_selector 'div#timestamp', text:'about 1 hour ago' }
        it{ should_not have_selector 'div#author', text:'by Batman' }
        it{ should_not have_link 'Batman', href:user_path(user) }
        it{ should_not have_selector 'form#new_comment' }
        it{ should_not have_button 'Create Comment' }
        it{ should_not have_selector 'div#comments' }
      end #without comments

      context "with comments" do
        before do
          create(:comment, commentable:sentence)
          render sentence, comment:Comment.new
        end

        subject{ Capybara.string(rendered) } 
        it{ should_not have_selector 'div#comments' }
      end
    end

    context "logged in as member" do
    before{ controller.stub(:current_user){ create(:user) }}
    context "without comments" do
      before{ render sentence, comment:Comment.new }

      subject{ Capybara.string(rendered) }
      it{ should have_selector 'div#content', text:'bajs' }
      it{ should have_selector 'div.timestamp', text:'about 1 hour ago' }
      it{ should have_selector 'div#author', text:'by Batman' }
      it{ should have_link 'Batman', href:user_path(user) }
      it{ should_not have_selector 'div#comments' }

      describe 'form#new_comment' do
        subject{ Capybara.string(rendered).find('form#new_comment')}
        it{ should have_button 'Create Comment' }
      end
    end #without comments

    context "with comments" do
      before do
        create(:comment, commentable:sentence, content:'<script>alert("you are hacked!")</script>')
        render sentence
      end
      subject{ Capybara.string(rendered).find('div#comments') } 
      it{ should have_selector 'div.comment', count:1 }
      it{ should have_content '<script>alert("you are hacked!")</script>' }
    end
  end
end
