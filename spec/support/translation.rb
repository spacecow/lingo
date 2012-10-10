def create_translation(page_id,jap,eng)
  translation = FactoryGirl.create(:translation, page_id:page_id)
  translation.languages << Japanese.new(content:jap) 
  translation.languages << English.new(content:eng) 
  translation
end
