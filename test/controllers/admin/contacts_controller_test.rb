require "test_helper"

class Admin::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_contacts_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_contacts_update_url
    assert_response :success
  end
end
