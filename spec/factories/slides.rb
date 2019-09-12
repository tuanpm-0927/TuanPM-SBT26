FactoryBot.define do
  factory :slide do |c|
    c.name {Faker::Name.name}
  end
end
