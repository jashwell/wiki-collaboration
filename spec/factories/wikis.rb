FactoryGirl.define do
  factory :wiki do
    title { "Post Title" }
    body { "Put a body here." }
    user
  end

  factory :invalid_wiki, parent: :wiki do
    title nil
  end

end
