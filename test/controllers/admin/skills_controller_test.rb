require "test_helper"

class Admin::SkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_skill_index_url
    assert_response :success
  end
end
