FactoryBot.define do
  factory :post1, class: "Post" do
    user_id { Faker::Number.number }
    time { Time.new(2019, 1, 1, 0, 0, 0, 0) }
    image_heading { "Heading 1" }
    image_caption { "Caption 1" }
    post_image { File.open(File.join(Rails.root, '/spec/factories/post1.png')) }
  end
  factory :post2, class: "Post" do
    user_id { Faker::Number.number }
    time { Time.new(2019, 1, 1, 0, 0, 0, 0) }
    image_heading { "Heading 2" }
    image_caption { "Caption 2" }
    post_image { File.open(File.join(Rails.root, '/spec/factories/post2.png')) }
  end
end
