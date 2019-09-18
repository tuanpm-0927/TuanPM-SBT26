
FactoryBot.define do
  factory :tour do |c|
    c.title{ Faker::Name.name }
    c.content{ Faker::Name.name }
    c.address_source{ Faker::Address.city }
    c.address_distance{ Faker::Address.city }
    c.price{ Faker::Number.number(digits: 13) }
    c.discount{ Faker::Number.between(from: 1, to: 100) }#=> 7 }
    c.price_discount{ Faker::Number.number(digits: 13) }
    c.total_day{ Faker::Name.name }
    c.total_member_max{ Faker::Number.between(from: 0, to: 100) }
    c.total_member_current{ Faker::Number.between(from: 0, to: 100) }
  end
end
