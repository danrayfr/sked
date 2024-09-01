require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get dashboard" do
    get dashboard_url
    assert_redirected_to new_session_url

    password_digest = BCrypt::Password.create("secret123456")

    user = User.create!(name: "dray", email_address: "dray@sked.com", password: password_digest)
    post session_url, params: { name: "dray", email_address: "dray@sked.com", password: password_digest }

    get dashboard_url
    assert_response :success
    assert_match user.email_address, response.body

    delete session_url
    assert_redirected_to new_session_url

    get dashboard_url
    assert_redirected_to new_session_url
  end
end
