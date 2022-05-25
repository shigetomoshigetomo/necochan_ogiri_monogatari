FactoryBot.define do
  factory :report do
    reason { Faker::Lorem.characters(number: 30) }
    association :member
  end
end