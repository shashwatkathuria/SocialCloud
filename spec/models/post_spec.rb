require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Post, type: :model do
  context 'Checking Mongoid Document ' do
    it { is_expected.to be_mongoid_document }
  end
  context 'Checking Database Collection ' do
    it { is_expected.to be_stored_in(collection: :posts) }
  end
  context 'Checking Fields' do
    it { is_expected.to have_field(:user_id).of_type(Integer) }
    it { is_expected.to have_field(:time).of_type(Time) }
    it { is_expected.to have_field(:image_heading).of_type(String) }
    it { is_expected.to have_field(:image_caption).of_type(String) }
    it { is_expected.to have_field(:image_content_type).of_type(String) }
    it { is_expected.to have_field(:image_base64).of_type(String) }
  end

  context 'Post1 Factory Bot Object' do
    before(:all){
      Faker::Config.random = Random.new(1)
      @post1 = create(:post1)
      Faker::Config.random = Random.new(1)
    }
    context 'Checking Field Values ' do
      it { expect(@post1.user_id).to eq 1 }
      it { expect(@post1.time).to eq Time.new(2019, 1, 1, 0, 0, 0, 0) }
      it { expect(@post1.image_heading).to eq "Heading 1" }
      it { expect(@post1.image_caption).to eq "Caption 1" }
    end
    context 'Checking Image MD5 Fingerprint' do
      it { expect(Digest::MD5.hexdigest(@post1.image_base64)).to eq Digest::MD5.hexdigest(Base64.strict_encode64(File.read(File.join(Rails.root, "spec/factories/post1.png")))) }
    end
    context 'Checking Image Content Type ' do
      it { expect(@post1.image_content_type).to eq 'image/png' }
    end

  end

  context 'Post2 Factory Bot Object' do
    before(:all){
      Faker::Config.random = Random.new(2)
      @post2 = create(:post2)
      Faker::Config.random = Random.new(2)
    }
    context 'Checking Field Values ' do
      it { expect(@post2.user_id).to eq 2 }
      it { expect(@post2.time).to eq Time.new(2019, 1, 1, 0, 0, 0, 0) }
      it { expect(@post2.image_heading).to eq "Heading 2" }
      it { expect(@post2.image_caption).to eq "Caption 2" }
    end
    context 'Checking Image MD5 Fingerprint' do
      it { expect(Digest::MD5.hexdigest(@post2.image_base64)).to eq Digest::MD5.hexdigest(Base64.strict_encode64(File.read(File.join(Rails.root, "spec/factories/post2.png")))) }
    end
    context 'Checking Image Content Type ' do
      it { expect(@post2.image_content_type).to eq 'image/png' }
    end

  end

end
