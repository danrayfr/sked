require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "new" do
    get new_user_url
    assert_response :success
  end

  test "new does not allow an authenticated user" do
    sign_in :danray
    get new_user_url
    assert_redirected_to root_url
  end

  test "creating a new user with an existing email address redirects to login screen" do
    get new_user_url

    user = users(:danray)

    assert_no_difference "User.count" do
      post users_url, params: { user: { name: "Kevin", email_address: user.email_address, password: "secret123456" } }
    end

    assert_redirected_to new_session_url(email_address: user.email_address)
  end

  test "create" do
    assert_difference "User.count", 1 do
      post users_url, params: { user: { name: "dray", email_address: "dray@sked.com", password: "secret123456" } }
    end

    assert_redirected_to root_url
    assert_not_nil Session.last[:user_id]
    user = User.last
    assert_equal user.id, Session.last[:user_id]
  end
end
