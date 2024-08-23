FactoryBot.define do
  factory :application do
    name {"name"}
    sequence(:email) {|n| "testuser#{n}@gmail.com"}
    experience { 12 }
    
    resume { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf') }
    job
   
  end
end
