FactoryGirl.define do
  factory :language do 
    factory :japanese do
      type 'Japanese'
    end
    factory :english do
      type 'English'
    end
  end

  factory :page do
    no 1
    project
  end

  factory :project do
    title 'Factory title'
  end

  factory :sentence do
    user
  end

  factory :translation do
  end

  factory :user do
  end
end
