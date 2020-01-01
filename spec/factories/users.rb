FactoryBot.define do
  factory :user, class: User do
    name { "Example User" }
    email { "exampleuser@booksharing.com" }
    password { "booksharing" }
    password_confirmation { "booksharing" }
    admin { false }
    activated { true }
    activated_at { Time.zone.now }
    factory :other_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end
    factory :deactivated_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      activated { false }
    end
    factory :admin_user do
      name { "Admin User" }
      email { "exampleuser@booksharing.gov" }
      password { "foobar" }
      password_confirmation { "foobar" }
      admin { true }
    end
  end
end
