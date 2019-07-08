FactoryBot.define do
  factory :message do
    body { Faker::Lorem.paragraph }
  end
end
