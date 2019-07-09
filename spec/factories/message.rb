FactoryBot.define do
  factory :message do
    body { Faker::Lorem.paragraph }
  end

  trait :with_user do
    user
  end
end
