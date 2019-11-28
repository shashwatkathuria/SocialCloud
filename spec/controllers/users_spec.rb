require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    # render_views
    # render_views -- To also include render html alongwith response
    before(:all) {

      Faker::Config.random = Random.new(2)
      @user1 = create(:user1)
      @user2 = create(:user2)
      Faker::Config.random = Random.new(2)
      # p User.all.to_a
    }
    context 'Logged In' do
      it {
        sign_in @user1
        get :index
        expect(response).to have_http_status(:success)
        should respond_with 200
       }
      it {
         sign_in @user1
         get :index
         should render_template('index')
         should render_with_layout('application')
       }
      it {
       sign_in @user1
       get :index
       should use_before_action :authenticate_user!
       }
    end
    context 'Not Logged In' do
      it 'Checking Response Status Code' do
        get :index
        expect(response).to have_http_status(:redirect)
        should respond_with 302
      end
      it 'Checking Rendered Views' do
         get :index
         should_not render_with_layout('application')
         should_not render_template('index')
      end
      it 'Checking If Authentication Step Is Used' do
       get :index
       should use_before_action :authenticate_user!
      end
     end
  end

  describe 'GET #search' do
    # render_views
    # render_views -- To also include render html alongwith response
    before(:all) {
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
      Faker::Config.random = Random.new(3)
      @user1 = create(:user1)
      @user2 = create(:user2)
      Faker::Config.random = Random.new(3)
    }
    it do
      get :search, params: {searchQuery:"a"}
      expect(response).to have_http_status(:success)
      should respond_with 200
    end
    it do
       get :search, params: {searchQuery:"a"}
       should render_template('search')
       should render_with_layout('application')
    end
    it do
      # Not possible to check if skipped - Stack Overflow
      get :search, params: {searchQuery:"a"}
      should use_before_action :authenticate_user!
    end
  end

  describe 'POST #search' do
    # render_views
    # render_views -- To also include render html alongwith response
    before(:all) {
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
      Faker::Config.random = Random.new(3)
      @user1 = create(:user1)
      @user2 = create(:user2)
      Faker::Config.random = Random.new(3)
    }
    it do
      post :search, params: {searchQuery:"a"}
      expect(response).to have_http_status(:redirect)
      should respond_with 302
    end
    it do
       post :search, params: {searchQuery:"a"}
       should_not render_template('search')
       should_not render_with_layout('application')
    end
    it do
      # Not possible to check if skipped - Stack Overflow
      post :search, params: {searchQuery:"a"}
      should use_before_action :authenticate_user!
    end
  end
end

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)
