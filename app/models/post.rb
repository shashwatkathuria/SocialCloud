class Post
  include Mongoid::Document
  include Mongoid::Paperclip
  field :user_id, type: Integer
  field :time, type: Time, default: ->{ Time.now }
  field :image_heading, type: String
  field :image_caption, type: String

  has_mongoid_attached_file :post_image
  validates_attachment_content_type :post_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  def self.column_names
    self.attribute_names
  end
end
