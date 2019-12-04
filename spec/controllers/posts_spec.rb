require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'
require 'rack/test'

RSpec.describe PostsController, type: :controller do
  describe '#index' do
    context 'GET' do
      # render_views -- To also include render html alongwith response
      before(:all) {
        Faker::Config.random = Random.new(2)
        @user1 = create(:user1)
        @user2 = create(:user2)
        @post1 = create(:post1)
        @post2 = create(:post2)
        Faker::Config.random = Random.new(2)
       }
       context 'Logged In' do
         it 'Checking Response Status Code' do
           sign_in @user1
           get :index
           expect(response).to have_http_status(:success)
           should respond_with 200
         end
         it 'Checking Rendered Templates and Layouts' do
            sign_in @user1
            get :index
            should render_template('index')
            should render_with_layout('application')
         end
         it 'Checking If Authentication Step Is Used' do
          sign_in @user1
          get :index
          should use_before_action :authenticate_user!
        end
       end
       context 'Not Logged In' do
         it 'Checking Response Status Code' do
           get :index
           expect(response).to have_http_status(:redirect)
           should respond_with 302
         end
         it 'Checking Rendered Templates and Layouts' do
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
  end

  describe '#show' do
    context 'GET' do
      # render_views -- To also include render html alongwith response
      before(:all) {
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.clean_with(:truncation)
        Mongoid.purge!
        Faker::Config.random = Random.new(2)
        @user1 = create(:user1)
        @user2 = create(:user2)
        @post1 = create(:post1)
        @post2 = create(:post2)
        Faker::Config.random = Random.new(2)
       }
       context 'Logged In' do
         context 'Signed In User\'s Post' do
           it 'Checking Response Status Code' do
             sign_in @user1
             get :show, params: {id: @post1.id}
             expect(response).to have_http_status(:success)
             should respond_with 200
           end

           it 'Checking Rendered Templates and Layouts' do
              sign_in @user1
              get :show, params: {id: @post1.id}
              should render_template('show')
              should render_with_layout('application')
            end
         end

         context 'Other User\'s Post' do
           it 'Checking Response Status Code' do
             sign_in @user1
             get :show, params: {id: @post2.id}
             expect(response).to have_http_status(:redirect)
             should respond_with 302
           end

           it 'Checking Rendered Templates and Layouts' do
              sign_in @user1
              get :show, params: {id: @post2.id}
              should_not render_template('show')
              should_not render_with_layout('application')
            end
         end

         it 'Checking If Authentication Step Is Used' do
          sign_in @user1
          get :show, params: {id: @post1.id}
          should use_before_action :authenticate_user!
        end

       end

       context 'Not Logged In' do
         it 'Checking Response Status Code' do
           get :show, params: {id: @post1.id}
           expect(response).to have_http_status(:redirect)
           should respond_with 302
         end
         it 'Checking Rendered Templates and Layouts' do
            get :show, params: {id: @post1.id}
            should_not render_with_layout('application')
            should_not render_template('index')
         end
         it 'Checking If Authentication Step Is Used' do
          get :show, params: {id: @post1.id}
          should use_before_action :authenticate_user!
         end
       end
    end
  end

  describe '#new' do
    context 'GET' do
      # render_views -- To also include render html alongwith response
      before(:all) {
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.clean_with(:truncation)
        Mongoid.purge!
        Faker::Config.random = Random.new(2)
        @user1 = create(:user1)
        @user2 = create(:user2)
        @post1 = create(:post1)
        @post2 = create(:post2)
        Faker::Config.random = Random.new(2)
       }
       context 'Logged In' do
         it 'Checking Response Status Code' do
           sign_in @user1
           get :new
           expect(response).to have_http_status(:success)
           should respond_with 200
         end

         it 'Checking Rendered Templates and Layouts' do
            sign_in @user1
            get :new
            should render_template('new')
            should render_with_layout('application')
          end

         it 'Checking If Authentication Step Is Used' do
          sign_in @user1
          get :new
          should use_before_action :authenticate_user!
        end

       end

       context 'Not Logged In' do
         it 'Checking Response Status Code' do
           get :new
           expect(response).to have_http_status(:redirect)
           should respond_with 302
         end
         it 'Checking Rendered Templates and Layouts' do
            get :new
            should_not render_template('new')
            should_not render_with_layout('application')
         end
         it 'Checking If Authentication Step Is Used' do
          get :new
          should use_before_action :authenticate_user!
         end
       end
    end
  end

  describe '#create' do
    context 'POST' do
      # render_views -- To also include render html alongwith response
      before(:all) {
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.clean_with(:truncation)
        Mongoid.purge!
        Faker::Config.random = Random.new(2)
        @user1 = create(:user1)
        @user2 = create(:user2)
        @post1 = create(:post1)
        @post2 = create(:post2)
        Faker::Config.random = Random.new(2)
        @to_upload_file = Rack::Test::UploadedFile.new(Rails.root.join("spec", "factories", "post3.png"))

        }

       #<ActionDispatch::Http::UploadedFile:0x000055f1a693f3d0 @tempfile=#<Tempfile:/tmp/RackMultipart20191203-5280-gmybdg.jpg>, @original_filename="jdh14.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"post[post_image]\"; filename=\"jdh14.jpg\"\r\nContent-Type: image/jpeg\r\n">
       context 'Logged In' do
         it 'Checking Response Status Code' do
           sign_in @user1
           post :create, params:{post:{image_heading:"Heading 3", image_caption:"Caption 3", post_image: @to_upload_file }}
           expect(response).to have_http_status(:redirect)
           should respond_with 302
         end

         it 'Checking Rendered Templates and Layouts' do
            sign_in @user1
            post :create, params:{post:{image_heading:"Heading 3", image_caption:"Caption 3", post_image: @to_upload_file }}
            should_not render_template('new')
            should_not render_with_layout('application')
          end

         it 'Checking If Authentication Step Is Used' do
          sign_in @user1
          post :create, params:{post:{image_heading:"Heading 3", image_caption:"Caption 3", post_image: @to_upload_file }}
          should use_before_action :authenticate_user!
        end

       end

       context 'Not Logged In' do
         it 'Checking Response Status Code' do
           post :create, params:{post:{image_heading:"Heading 3", image_caption:"Caption 3", post_image: @to_upload_file }}
           expect(response).to have_http_status(:redirect)
           should respond_with 302
         end
         it 'Checking Rendered Templates and Layouts' do
            post :create, params:{post:{image_heading:"Heading 3", image_caption:"Caption 3", post_image: @to_upload_file }}
            should_not render_template('new')
            should_not render_with_layout('application')
         end
         it 'Checking If Authentication Step Is Used' do
          post :create, params:{post:{image_heading:"Heading 3", image_caption:"Caption 3", post_image: @to_upload_file }}
            should use_before_action :authenticate_user!
         end
       end
    end
  end




end
