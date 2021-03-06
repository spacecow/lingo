require 'spec_helper'

describe 'Pages show, create translation' do
  let(:_page){ FactoryGirl.create(:page) }
  before(:each) do
    signin
    visit project_page_path(_page.project, _page)
    fill_in 'translation_languages_attributes_0_popular_sentence_attributes_content', with:'nihongo'
    fill_in 'translation_languages_attributes_1_popular_sentence_attributes_content', with:'japanese'
  end
  let(:user){ User.last }

  it "saves the translation to db" do
    lambda do click_button 'Create Translation'
    end.should change(Translation,:count).by(1)
  end
  it "saves the two languages to db" do
    lambda do click_button 'Create Translation'
    end.should change(Language,:count).by(2)
  end
  it "saves the two translated sentences to db" do
    lambda do click_button 'Create Translation'
    end.should change(Sentence,:count).by(2)
  end
  it "saves notifications about the sentences to db" do
    lambda do click_button 'Create Translation'
    end.should change(Notification,:count).by(2)
  end
  it "saves a notificment to other users about the created sentences to db" do
    create(:user)
    lambda do click_button 'Create Translation'
    end.should change(Noticement,:count).by(2)
  end

  context 'saved' do
    before{ click_button 'Create Translation' }
    let(:_translation){ Translation.last }

    context 'translation' do
      subject(:translation){ _translation }
      its(:page_id){ should eq _page.id }
    end

    context 'japanese' do
      let(:_japanese){ _translation.japanese }
      subject(:japanese){ _japanese }
      its(:type){ should eq 'Japanese' }
      its(:translation_id){ should eq _translation.id }

      context 'sentence' do
        subject(:sentence){ _japanese.sentences.first }
        its(:content){ should eq 'nihongo' }
        its(:user_id){ should eq user.id }
        its(:language_id){ should eq _japanese.id }
      end
    end #english

    context 'english' do
      let(:_english){ _translation.english }
      subject(:english){ _english }
      its(:type){ should eq 'English' }
      its(:translation_id){ should eq _translation.id }

      context 'sentence' do
        subject(:sentence){ _english.sentences.first }
        its(:content){ should eq 'japanese' }
        its(:user_id){ should eq user.id }
        its(:language_id){ should eq _english.id }
      end
    end #japanese
  end #saved

  context "blank save" do
    before do
      fill_in 'translation_languages_attributes_1_popular_sentence_attributes_content', with:''
    end

    it "saves the translation to db" do
      lambda do click_button 'Create Translation'
      end.should change(Translation,:count).by(1)
    end
    it "saves the two languages to db" do
      lambda do click_button 'Create Translation'
      end.should change(Language,:count).by(1)
    end
    it "saves the two translated sentences to db" do
      lambda do click_button 'Create Translation'
      end.should change(Sentence,:count).by(1)
    end
  end
end

describe 'Pages show, create translation' do
  context "error" do
    it "both languages cannot be left blank"
  end #error
end
