FactoryBot.define do
  factory :post1, class: "Post" do
    user_id { 1 }
    time { Time.new(2019, 1, 1, 0, 0, 0, 0) }
    image_heading { "Heading 1" }
    image_caption { "Caption 1" }
    image_base64 { Base64.strict_encode64(File.read(File.join(Rails.root, '/spec/factories/post1.png'))) }
    image_content_type { MIME::Types.type_for(File.join(Rails.root, '/spec/factories/post1.png')).first.content_type }
  end
  factory :post2, class: "Post" do
    user_id { 2 }
    time { Time.new(2019, 1, 1, 0, 0, 0, 0) }
    image_heading { "Heading 2" }
    image_caption { "Caption 2" }
    image_base64 { Base64.strict_encode64(File.read(File.join(Rails.root, '/spec/factories/post2.png'))) }
    image_content_type { MIME::Types.type_for(File.join(Rails.root, '/spec/factories/post2.png')).first.content_type }
  end
end
