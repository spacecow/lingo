def create_translation(page_id,jap,eng)
  translation = FactoryGirl.create(:translation, page_id:page_id)
  FactoryGirl.create(:japanese, translation:translation)
  FactoryGirl.create(:english, translation:translation)
  #translation.languages << Japanese.new(content:jap) 
  #translation.languages << English.new(content:eng) 
  translation
end
