require 'spec_helper'

describe 'languages/history.html.erb' do
  let(:language){ create(:japanese) }
  
  context "without sentences" do
    before{ render 'languages/history', language:language }

    subject{ Capybara.string(rendered)}
    it{ should_not have_selector 'div#sentences' }
  end


  context "user not logged in" do
    before{ controller.stub(:current_user){ nil }}

    context "with sentences" do
      before do
        create(:sentence, language:language)
        render 'languages/history', language:language
      end

      subject{ Capybara.string(rendered)}
      it{ should_not have_selector 'div#sentences' }
    end
  end

  context "member logged in" do
    before{ controller.stub(:current_user){ create(:user)}}

    context "with one sentence" do
      let!(:sentence){ create(:sentence, language:language, content:'oh yeah')}
     
      context "without comments" do
        before{ render 'languages/history', language:language }

        describe "div#sentences" do
          subject{ Capybara.string(rendered).find('div#sentences')}
          it{ should have_selector 'div.sentence', count:1 }
          it{ should_not have_content 'oh yeah' }

          describe "div.sentence" do
            subject{ Capybara.string(rendered).find('div#sentences div.sentence')}
            it{ should have_selector 'form#new_comment' }
          end
        end #div#sentences
      end #without comments

      context "with comments" do
        before do
          create(:comment, commentable:sentence)
          render 'languages/history', language:language
        end

        describe "div#sentences" do
          subject{ Capybara.string(rendered).find('div#sentences')}
          it{ should have_content 'oh yeah' }
        end #div#sentences
      end #with comments
      
    end #with one sentence

    context "with two sentence" do
      before do
        create(:sentence, language:language, content:'oh yeah')
        create(:sentence, language:language)
        render 'languages/history', language:language
      end

      describe "div#sentences" do
        subject{ Capybara.string(rendered).find('div#sentences')}
        it{ should have_selector 'div.sentence', count:2 }

        describe "div.sentence" do
          subject{ Capybara.string(rendered).find('div#sentences div.sentence')}
          it{ should have_content 'oh yeah' }
          it{ should have_selector 'form#new_comment' }
        end
      end
    end
  end

  #before do
  #  create(:sentence, language:japanese)
  #  controller.stub(:current_user){ nil }
  #end

  #context "containing only one sentence" do
  #  before{ render 'languages/history', language:japanese }

  #  describe 'div.history' do
  #    subject{ Capybara.string(rendered).find('div.history') }
  #    it{ should have_selector 'div.sentence', count:1 }
  #  end
  #end

  #context "containing more than one sentence" do
  #  before do
  #    create(:sentence, language:japanese)
  #    render 'languages/history', language:japanese
  #  end

  #  describe 'div.history' do
  #    subject{ Capybara.string(rendered).find('div.history') }
  #    it{ should have_selector 'div.sentence', count:2 }
  #  end
  #end
  #
end
