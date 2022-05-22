FactoryBot.define do
  factory :post do
    content { Faker::Lorem.characters(number:30) }
    member
    board
  end
end