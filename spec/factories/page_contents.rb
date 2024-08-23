FactoryBot.define do
  factory :page_content do
    home_header {"header sample"}
    mission {"s" * 256}
    vision {"s" * 256}
    about_header {"sample about_header"}
    about_us {"s" * 256}
    history {"s" * 256}
    ceo {"sample ceo"}
    contact_header {"sample contact_header"}
    ceo_img { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.png'), 'image/png') }
    home_img { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.png'), 'image/png') }
  end
end
