FactoryGirl.define do
  factory :comment do
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

  factory :page do
    no 1
    project
  end

  factory :project do
    sequence(:title){|n| "Factory title #{n}"}
  end

  factory :sentence do
    user
    association :language, factory: :language, type:'Japanese'
  end

  factory :translation do
    page
  end

  factory :user do
  end
end
