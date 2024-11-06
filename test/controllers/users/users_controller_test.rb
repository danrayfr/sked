require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @organization = organizations(:myspace)
    @join_code = @organization.join_code
  end

  test "new" do
    get join_url(@organization.uid, @join_code)
    assert_response :success
  end

  test "new does not allow an authenticated user" do
    sign_in :danray

    get join_url(@organization.uid, @join_code)
    assert_redirected_to root_url
  end

  test "new requires an organization uid and join code" do
    get join_url(@organization.uid, "not")
    assert_response :not_found
  end

  test "creating a new user with an existing email address redirects to login screen" do
    assert_no_difference "User.count" do
      post join_url(@organization.uid, @join_code), params: { user: { name: "Another danray", email_address: users(:danray).email_address, password: "secret123456" } }
    end

    assert_redirected_to new_session_url(email_address: users(:danray).email_address)
  end

  test "create" do
    assert_difference "User.count", 1 do
      post join_url(@organization.uid, @join_code), params: { user: { name: "dray", email_address: "dray@sked.com", password: "secret123456" } }
    end

    assert_redirected_to root_url
    assert_not_nil Session.last[:user_id]
    user = User.last
    assert_equal user.id, Session.last[:user_id]
  end
end
