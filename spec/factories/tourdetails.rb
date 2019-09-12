FactoryBot.define do
  factory :tourdetail do |c|
    c.day_start{ Time.now }
    c.total_booking{ Faker::Number.between(from: -100, to: 100) }
    c.total_current_booking{ Faker::Number.between(from: -100, to: 100) }
  end
end
