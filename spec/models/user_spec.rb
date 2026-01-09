require 'spec_helper'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  # Provide a valid subject for uniqueness matchers to avoid validation conflicts
  subject { build(:user1) }

  context 'Checking Fields' do
    # Ensure Mongoid matchers are used
    it { is_expected.to have_field(:phone) }
    it { is_expected.to have_field(:email) }
    it { is_expected.to have_field(:first_name) }
    it { is_expected.to have_field(:last_name) }
    it { is_expected.to have_field(:username) }
    it { is_expected.to have_field(:followers) }
    it { is_expected.to have_field(:following) }
  end

  context 'Checking Database Columns' do
    it { should have_db_column(:first_name) }
    it { should have_db_column(:last_name) }
    it { should have_db_column(:username) }
    it { should have_db_column(:followers) }
    it { should have_db_column(:following) }
  end

  context 'Checking Uniqueness and Presence of Fields' do
    # Create an existing record so the matcher can test uniqueness against it
    before { create(:user1) } 
    
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  context 'User1 Factory Bot Object' do
    before(:each){
      # We reset the seed once here for the factory creation
      Faker::Config.random = Random.new(1)
      @user1 = create(:user1)
    }

    context 'Checking Field Values' do
      # To match exactly, we must reset the seed AND burn the specific number of calls
      # that happened inside the factory to reach that specific field.
      it { 
        Faker::Config.random = Random.new(1)
        expect(@user1.first_name).to eq Faker::Name.first_name 
      }
      it { 
        Faker::Config.random = Random.new(1)
        Faker::Name.first_name # burn 1
        expect(@user1.last_name).to eq Faker::Name.last_name 
      }
      it { 
        Faker::Config.random = Random.new(1)
        Faker::Name.first_name # burn 1
        Faker::Name.last_name  # burn 2
        expect(@user1.email).to eq Faker::Internet.email 
      }
      it { 
        Faker::Config.random = Random.new(1)
        Faker::Name.first_name # burn 1
        Faker::Name.last_name  # burn 2
        Faker::Internet.email  # burn 3
        expect(@user1.phone).to eq Faker::PhoneNumber.phone_number 
      }
      it { 
        Faker::Config.random = Random.new(1)
        Faker::Name.first_name # burn 1
        Faker::Name.last_name  # burn 2
        Faker::Internet.email  # burn 3
        Faker::PhoneNumber.phone_number # burn 4
        expect(@user1.username).to eq Faker::Internet.username 
      }
    end

    it 'checks password' do 
      expect(@user1.valid_password?('password1')).to be_truthy 
    end
  end

  context 'User2 Factory Bot Object' do
    before(:each){
      Faker::Config.random = Random.new(2)
      @user2 = create(:user2)
    }

    context 'Checking Field Values' do
      it { 
        Faker::Config.random = Random.new(2)
        expect(@user2.first_name).to eq Faker::Name.first_name 
      }
      it { 
        Faker::Config.random = Random.new(2)
        Faker::Name.first_name 
        expect(@user2.last_name).to eq Faker::Name.last_name 
      }
      it { 
        Faker::Config.random = Random.new(2)
        Faker::Name.first_name
        Faker::Name.last_name
        expect(@user2.email).to eq Faker::Internet.email 
      }
      it { 
        Faker::Config.random = Random.new(2)
        Faker::Name.first_name
        Faker::Name.last_name
        Faker::Internet.email
        expect(@user2.phone).to eq Faker::PhoneNumber.phone_number 
      }
      it { 
        Faker::Config.random = Random.new(2)
        Faker::Name.first_name
        Faker::Name.last_name
        Faker::Internet.email
        Faker::PhoneNumber.phone_number
        expect(@user2.username).to eq Faker::Internet.username 
      }
    end

    it 'checks password' do 
      expect(@user2.valid_password?('password2')).to be_truthy 
    end
  end
end
