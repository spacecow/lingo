def create_translation(page_id,eng,jap)
  translation = FactoryGirl.create(:translation, page_id:page_id)
  translation.languages << English.new(content:eng) 
  translation.languages << Japanese.new(content:jap) 
  translation
end
