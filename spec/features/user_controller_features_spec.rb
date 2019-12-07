require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'

describe "Signing Up Process And Verifying New User Information", type: :feature do
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Mongoid.purge!
    Faker::Config.random = Random.new(3)
    @user1 = create(:user1)
    @user2 = create(:user2)
    Faker::Config.random = Random.new(3)
    @first_name = "FirstName3"
    @last_name = 'LastName3'
    @phone = "99999191919"
    @email = "email3@gmail.com"
    @username = "UserName3"
    @password = "password3"
  end
  # before(:each) do
    # User.make(email: @user1.email, password: 'password1')
  # end
  before(:all) do
    visit '/users/sign_up'
    within("#new_user") do
      fill_in 'user_first_name', with: @first_name
      fill_in 'user_last_name', with: @last_name
      fill_in 'user_phone', with: @phone
      fill_in 'user_email', with: @email
      fill_in 'user_username', with: @username
      fill_in 'user_password', with: @password
      fill_in 'user_password_confirmation', with: @password
    end
    click_button 'Sign Up'
  end

  it 'Checks If User Is Created Successfully' do
    expect(User.count).to eq 3
    expect(page).to have_content 'Logged in as email3@gmail.com'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'Checks New User Information' do
    @user = User.where(email:@email).first
    expect(@user.first_name).to eq @first_name
    expect(@user.last_name).to eq @last_name
    expect(@user.username).to eq @username
    expect(@user.phone).to eq @phone
    expect(@user.email).to eq @email
    expect(@user.valid_password?("password3")).to be_truthy

  end


end


describe "Signing In Process And Visiting Profile Pages", type: :feature do
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Mongoid.purge!
    Faker::Config.random = Random.new(3)
    @user1 = create(:user1)
    @user2 = create(:user2)
    Faker::Config.random = Random.new(3)
  end
  # before(:each) do
    # User.make(email: @user1.email, password: 'password1')
  # end
  before(:each) do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'user_login', with: @user1.email
      fill_in 'user_password', with: 'password1'
    end
    click_button 'Login'
  end

  it "Checking Valid Sign In" do
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Logged in as ' + @user1.email
  end

  it 'Checks Whether Redirected to Feed Page' do
    expect(page).to have_current_path root_path
  end

  it 'Visits User\'s Profile Page Checks Valid Profile Details' do
    visit '/users'
    expect(page).to have_content @user1.first_name + " " +  @user1.last_name
    expect(page).to have_content @user1.email
    expect(page).to have_content @user1.phone
    expect(page).to have_content @user1.username
  end

  it 'Logs Out The User And Checks If Done Successfully' do
    visit '/users/sign_out'
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_current_path root_path
  end

end

describe "Editing User Profile Process And Checking Updated Details", type: :feature do
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Mongoid.purge!
    Faker::Config.random = Random.new(3)
    @user1 = create(:user1)
    @user2 = create(:user2)
    Faker::Config.random = Random.new(3)
  end

  before(:all) do
    @first_name = "FirstName1"
    @last_name = 'LastName1'
    @phone = "91919191919"
    @email = "email1@gmail.com"
    @username = "UserName1"
    @password = "password1"
    sign_in @user1
    visit '/users/edit'
    within("#edit_user") do
      fill_in 'user_first_name', with: @first_name
      fill_in 'user_last_name', with: @last_name
      fill_in 'user_phone', with: @phone
      fill_in 'user_email', with: @email
      fill_in 'user_username', with: @username
      fill_in 'user_password', with: "password11"
      fill_in 'user_password_confirmation', with: "password11"
      fill_in 'user_current_password', with: @password
    end
    find("input[value='Update User']", visible: false).click
  end

  it "Checking Valid Update of Details" do
    expect(page).to have_content 'Your account has been updated successfully.'
    expect(page).to have_content 'Logged in as ' + @email
  end

  it 'Checks Whether Redirected to Feed Page' do
    expect(page).to have_current_path root_path
  end

  it 'Checks Updated User Information' do
    @user = User.where(email:@email).first
    expect(@user.first_name).to eq @first_name
    expect(@user.last_name).to eq @last_name
    expect(@user.username).to eq @username
    expect(@user.phone).to eq @phone
    expect(@user.email).to eq @email
    expect(@user.valid_password?("password11")).to be_truthy
  end


  it 'Logs Out The User And Checks If Done Successfully' do
    visit '/users/sign_out'
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_current_path root_path
  end

end
