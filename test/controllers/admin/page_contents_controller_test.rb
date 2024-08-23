require "test_helper"

class Admin::PageContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_page_contents_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_page_contents_update_url
    assert_response :success
  end
end
