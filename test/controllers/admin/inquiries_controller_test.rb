require "test_helper"

class Admin::InquiriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_inquiry_index_url
    assert_response :success
  end
end
