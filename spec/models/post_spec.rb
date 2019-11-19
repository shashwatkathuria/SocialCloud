require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Post, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_stored_in(collection: :posts) }
  it { is_expected.to have_field(:user_id).of_type(Integer) }
  it { is_expected.to have_field(:time).of_type(Time) }
  it { is_expected.to have_field(:image_heading).of_type(String) }
  it { is_expected.to have_field(:image_caption).of_type(String) }
  it { should have_attached_file(:post_image) }
  it { should validate_attachment_content_type(:post_image).allowing('image/png', 'image/gif', 'image/jpeg', 'image/jpg') }
end
