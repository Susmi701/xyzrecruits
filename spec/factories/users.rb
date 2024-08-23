FactoryBot.define do
  factory :user do
    name  {"user name"}
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
  end
end
