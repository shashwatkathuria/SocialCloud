require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create!(
      username: "testuser",
      first_name: "FirstName",
      last_name: "LastName",
      email: "testuser@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    sign_in @user, scope: :user
    @post = Post.create!(
      user_id: @user.id,
      image_heading: "Sample Heading",
      image_caption: "Sample Caption",
      image_content_type: "image/png",
      image_base64: "iVBORw0KGgoAAAANSUhEUgAA..."
    )
  end

  test "should get index" do
    get posts_path
    assert_response :success
  end

  test "should get show" do
    get post_path(@post)
    assert_response :success
  end

  test "should get new" do
    get new_post_path
    assert_response :success
  end

  test "should get create" do
    get posts_path
    assert_response :success
  end

  test "should get search" do
    get posts_search_url
    assert_response :success
  end

end
