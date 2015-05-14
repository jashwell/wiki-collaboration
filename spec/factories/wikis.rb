require 'faker'

FactoryGirl.define do
  factory :wiki do
    title { Faker::Lorem.word }
    body { Faker::Lorem.word }
    user
  end

  factory :invalid_wiki, parent: :wiki do
    title nil
  end

end
