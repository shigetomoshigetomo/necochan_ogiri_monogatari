FactoryBot.define do
  factory :board do
    title { Faker::Lorem.characters(number: 10) }
    member
  end
end
