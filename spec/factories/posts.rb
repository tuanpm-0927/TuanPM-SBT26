FactoryBot.define do
  factory :post do |c|
    association :user
    association :category
    c.title {Faker::Name.name}
    c.content {Faker::Lorem.word}
  end
end
