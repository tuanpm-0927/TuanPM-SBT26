FactoryBot.define do
  password = "123123"  

  factory :user do |c|
    c.fullname {Faker::Name.name}
    c.email {Faker::Internet.email}
    c.birthday {Date.new 1997, 12, 11}
    c.password {password}
    c.password_confirmation {password}
    c.phonenumber {Faker::PhoneNumber.phone_number}
    c.address{ Faker::Address.city}
    c.admin{ User.admins[:user] }
    c.money{ Faker::Number.digit }
    c.activated{ true }
  end
end
