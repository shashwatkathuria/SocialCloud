require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'

describe "Index Page of User\'s Posts Process", type: :feature do
  before(:all) do
    Capybara.current_driver = :selenium
  end
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Mongoid.purge!
    Faker::Config.random = Random.new(3)
    @user1 = create(:user1)
    @user2 = create(:user2)
    @post1 = create(:post1)
    @post2 = create(:post2, user_id: 1)
    Faker::Config.random = Random.new(3)
  end

  before(:all) do
    sign_in @user1
    visit posts_path
  end

  it 'Checking Posts Info and Page Route' do
    visit '/posts'
    expect(all("img")[0][:src]).to eq "data:#{ @post1.image_content_type };base64,#{ @post1.image_base64 }"
    expect(page).to have_content @post1.image_heading
    expect(page).to have_content @post1.image_caption
    expect(all("img")[1][:src]).to eq "data:#{ @post2.image_content_type };base64,#{ @post2.image_base64 }"
    expect(page).to have_content @post2.image_heading
    expect(page).to have_content @post2.image_caption

    expect(page).to have_current_path posts_path
  end

end

describe "Showing Post Process", type: :feature do
  before(:all) do
    Capybara.current_driver = :selenium
  end
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Mongoid.purge!
    Faker::Config.random = Random.new(3)
    @user1 = create(:user1)
    @user2 = create(:user2)
    @post1 = create(:post1)
    @post2 = create(:post2, user_id: 1)
    Faker::Config.random = Random.new(3)
  end

  before(:all) do
    sign_in @user1
    visit posts_path
    find("a[href='#{post_path(@post1)}']").click
  end

  it 'Checking Post Info and Page Route' do
    expect(find("img")[:src]).to eq "data:#{ @post1.image_content_type };base64,#{ @post1.image_base64 }"
    expect(page).to have_content @post1.image_heading
    expect(page).to have_content @post1.image_caption
    expect(page).to_not have_content @post2.image_heading
    expect(page).to_not have_content @post2.image_caption

    expect(page).to have_current_path post_path(@post1)
  end

end

describe "Deleting Post Process", type: :feature do
  before(:all) do
    Capybara.current_driver = :selenium
  end
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Mongoid.purge!
    Faker::Config.random = Random.new(3)
    @user1 = create(:user1)
    @user2 = create(:user2)
    @post1 = create(:post1)
    @post2 = create(:post2, user_id: 1)
    Faker::Config.random = Random.new(3)
  end

  before(:all) do
    sign_in @user1
    visit posts_path
    find("a", :text => "Delete Post", match: :first).click
    page.driver.browser.switch_to.alert.accept
  end

  it 'Checking Total Number of Posts, Successful Post Deletion and Page Route ' do
    sleep(1) # Waiting for transaction to complete
    expect(Post.where(user_id: @user1.id).count).to eq 1

    expect(page).to have_content "Post successfully deleted."
    expect(page).to_not have_content @post1.image_heading
    expect(page).to_not have_content @post1.image_caption
    expect(find("img")[:src]).to eq "data:#{ @post2.image_content_type };base64,#{ @post2.image_base64 }"
    expect(page).to have_content @post2.image_heading
    expect(page).to have_content @post2.image_caption

    expect(page).to have_current_path posts_path
  end

end

describe "Creating New Post Process", type: :feature do
  before(:all) do
    Capybara.current_driver = :selenium
  end
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Mongoid.purge!
    Faker::Config.random = Random.new(3)
    @user1 = create(:user1)
    @user2 = create(:user2)
    @post1 = create(:post1)
    @post2 = create(:post2, user_id: 1)
    Faker::Config.random = Random.new(3)
  end

  before(:all) do
    sign_in @user1
    visit new_post_path
    within("#new_post") do
      fill_in 'post_image_heading', with: "Heading 3"
      fill_in 'post_image_caption', with: "Caption 3"
      attach_file('post[post_image]', Rails.root.join("spec", "factories", "post3.png"), visible: false)
    end
    all("label[class='btn btn-default standardButton center-block']")[1].click
  end

  it 'Checking Total Number of Posts, Successful Post Addition and Page Route' do
    expect(Post.where(user_id: @user1.id).count).to eq 3

    @createdPost = Post.where(user_id: @user1.id, image_heading: "Heading 3").first
    expect(all("img")[0][:src]).to eq "data:#{ @createdPost.image_content_type };base64,#{ @createdPost.image_base64 }"
    expect(page).to have_content "Heading 3"
    expect(page).to have_content "Caption 3"

    expect(page).to have_current_path posts_path
  end

end


describe "Searching Post Process", type: :feature do
  before(:all) do
    Capybara.current_driver = :selenium
  end
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Mongoid.purge!
    Faker::Config.random = Random.new(3)
    @user1 = create(:user1)
    @user2 = create(:user2)
    @post1 = create(:post1)
    @post2 = create(:post2, user_id: 1)
    Faker::Config.random = Random.new(3)
  end

  before(:all) do
    sign_in @user1
    visit posts_path
    find("input[placeholder='Search Post']").fill_in with: "2"
    all("button", :text => "Search")[1].click
  end

  it 'Checking Search Results and Page Route' do
    expect(find("img")[:src]).to eq "data:#{ @post2.image_content_type };base64,#{ @post2.image_base64 }"
    expect(page).to have_content @post2.image_heading
    expect(page).to have_content @post2.image_caption
    expect(page).to_not have_content @post1.image_heading
    expect(page).to_not have_content @post1.image_caption

    expect(page).to have_current_path url_for(action: 'search', controller: 'posts', searchQuery: "2").remove("http://www.example.com")
  end

end
