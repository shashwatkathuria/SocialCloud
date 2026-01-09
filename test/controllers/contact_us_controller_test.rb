require 'test_helper'

class ContactUsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contact_us_url
    assert_response :success
  end

end
