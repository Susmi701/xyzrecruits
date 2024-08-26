FactoryBot.define do
  factory :inquiry do
    name {"testuser"}
    email {"testuser@gmail.com"}
    message {"message"*10}
  end
end
