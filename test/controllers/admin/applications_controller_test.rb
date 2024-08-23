require "test_helper"

class Admin::ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_applications_index_url
    assert_response :success
  end
end
