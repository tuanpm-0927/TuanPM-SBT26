FactoryBot.define do
  factory :category do |c|
    c.name {Faker::Name.name}
    c.type_post {Category.type_posts[:user]}
  end
end
