require "test_helper"

class Users::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "show" do
    sign_in :danray

    get user_profile_url(users(:danray))
    assert_response :success
  end
end
