class Post
  include Mongoid::Document

  field :user_id, type: Integer
  field :time, type: Time, default: ->{ Time.now }
  field :image_heading, type: String
  field :image_caption, type: String
  field :image_content_type, type: String
  field :image_base64, type: String

  def self.column_names
    self.attribute_names
  end
end
