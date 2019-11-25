
FactoryBot.define do
  factory :user1, class: "User" do
    first_name { Faker::Name.first_name  }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    username { Faker::Internet.username }
    password { 'password1' }
    password_confirmation { 'password1' }
  end
  factory :user2, class: "User" do
    first_name { Faker::Name.first_name  }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    username { Faker::Internet.username }
    password { 'password2' }
    password_confirmation { 'password2' }
  end
end
