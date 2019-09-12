FactoryBot.define do
  factory :category_image do
    category
    image fixture_file_upload( Rails.root + 'spec/fixtures/images/example.jpg', "image/jpg")
  end
end
