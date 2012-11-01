FactoryGirl.define do
  factory :comment do
    user
    content 'Factory content'
  end

  factory :language do 
    factory :japanese do
      type 'Japanese'
    end
    factory :english do
      type 'English'
    end
    translation
  end

  #factory :noticement do
  #  user
  #  notification
  #end

  #factory :notification do
  #  association :notifiable, factory: :sentence
  #  association :creator, factory: :user
  #  type_mask 1 
  #  content 'Factory content'
  #end

  factory :page do
    no 1
    project
  end

  factory :project do
    sequence(:title){|n| "Factory title #{n}"}
  end

  factory :sentence do
    user
    content 'Factory content'
    association :language, factory: :language, type:'Japanese'
  end

  factory :translation do
    page
  end

  factory :user do
  end
end
