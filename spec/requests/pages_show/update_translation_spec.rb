require 'spec_helper'


describe 'Pages show, updates translation' do
  let(:_page){ FactoryGirl.create(:page) }
  before(:each) do
    signin
    @user = User.last
    @second_user = create(:user)
    translation = create(:translation, page:_page)
    japanese = create(:japanese, translation:translation)
    create(:sentence, user:@user, language:japanese, content:'eigo') 
    english = create(:english, translation:translation)
    create(:sentence, user:@second_user, language:english, content:'english') 
    visit project_page_path(_page.project, _page)
    fill_in 'translation_languages_attributes_0_popular_sentence_attributes_content', with:'nihongo'
    fill_in 'translation_languages_attributes_1_popular_sentence_attributes_content', with:'japanese'
  end

  it "saves the translation to db" do
    lambda do click_button 'Update Translation'
    end.should change(Translation,:count).by(0)
  end
  it "saves the two languages to db" do
    lambda do click_button 'Update Translation'
    end.should change(Language,:count).by(0)
  end
  it "saves the two translated sentences to db" do
    lambda do click_button 'Update Translation'
    end.should change(Sentence,:count).by(1)
  end

  context 'updated' do
    before{ click_button 'Update Translation' }
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
        its(:user_id){ should eq @user.id }
        its(:language_id){ should eq _japanese.id }
      end
    end

    context 'old english' do
      let(:_english){ _translation.english }
      subject(:english){ _english }
      its(:type){ should eq 'English' }
      its(:translation_id){ should eq _translation.id }

      context 'sentence' do
        subject(:sentence){ _english.sentences.first }
        its(:content){ should eq 'english' }
        its(:user_id){ should eq @second_user.id }
        its(:language_id){ should eq _english.id }
      end
    end

    context 'new english' do
      let(:_english){ _translation.english }
      subject(:english){ _english }
      its(:type){ should eq 'English' }
      its(:translation_id){ should eq _translation.id }

      context 'sentence' do
        subject(:sentence){ _english.sentences.last }
        its(:content){ should eq 'japanese' }
        its(:user_id){ should eq @user.id }
        its(:language_id){ should eq _english.id }
      end
    end
  end #updated

  context "blank update" do
    before do
      fill_in 'translation_languages_attributes_0_popular_sentence_attributes_content', with:''
      fill_in 'translation_languages_attributes_1_popular_sentence_attributes_content', with:''
    end

    it "saves the translation to db" do
      lambda do click_button 'Update Translation'
      end.should change(Translation,:count).by(0)
    end
    it "saves the two languages to db" do
      lambda do click_button 'Update Translation'
      end.should change(Language,:count).by(0)
    end
    it "saves the two translated sentences to db" do
      lambda do click_button 'Update Translation'
      end.should change(Sentence,:count).by(0)
    end
  end #blank update
end
