require 'spec_helper'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  context 'Checking Fields ' do
    it { is_expected.to have_field(:phone) }
    it { is_expected.to have_field(:email) }
    it { is_expected.to have_field(:first_name) }
    it { is_expected.to have_field(:last_name) }
    it { is_expected.to have_field(:username) }
    it { is_expected.to have_field(:followers) }
    it { is_expected.to have_field(:following) }
  end

  context 'Checking Database Columns ' do
    it { should have_db_column(:first_name) }
    it { should have_db_column(:last_name) }
    it { should have_db_column(:username) }
    it { should have_db_column(:followers) }
    it { should have_db_column(:following) }
  end

  context 'Checking Uniqueness and Presence of Fields' do
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end

  context 'Checking Serializability of followers and folowing ' do
    it { should serialize(:followers) }
    it { should serialize(:following) }
  end

  context 'User1 Factory Bot Object' do
    before(:all){
      Faker::Config.random = Random.new(1)
      @user1 = create(:user1)
      Faker::Config.random = Random.new(1)
    }
    context 'Checking Field Values ' do
      it { expect(@user1.first_name).to eq Faker::Name.first_name }
      it { expect(@user1.last_name).to eq Faker::Name.last_name }
      it { expect(@user1.email).to eq Faker::Internet.email }
      it { expect(@user1.phone).to eq Faker::PhoneNumber.phone_number }
      it { expect(@user1.username).to eq Faker::Internet.username }
    end
    context 'Checking Password' do
      it { expect(@user1.valid_password?('password1')).to be_truthy }
    end
  end

  context 'User2 Factory Bot Object' do
    before(:all){
      Faker::Config.random = Random.new(2)
      @user2 = create(:user2)
      Faker::Config.random = Random.new(2)
    }
    context 'Checking Field Values ' do
      it { expect(@user2.first_name).to eq Faker::Name.first_name }
      it { expect(@user2.last_name).to eq Faker::Name.last_name }
      it { expect(@user2.email).to eq Faker::Internet.email }
      it { expect(@user2.phone).to eq Faker::PhoneNumber.phone_number }
      it { expect(@user2.username).to eq Faker::Internet.username }
    end
    context 'Checking Password' do
      it { expect(@user2.valid_password?('password2')).to be_truthy }
    end
  end
end
