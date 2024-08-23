require "test_helper"

class Admin::JobControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_job_index_url
    assert_response :success
  end
end
