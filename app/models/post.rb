class Post
  include Mongoid::Document
  field :name, type: String
  field :content, type: String
  field :user_id, type: Integer
  field :time, type: Time, default: ->{ Time.now }
end
