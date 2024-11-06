require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get dashboard_url
    assert_redirected_to new_session_path

    password_digest = BCrypt::Password.create("secret123456")

    user = User.create!(name: "dray", email_address: "dray@sked.com", password: password_digest)
    post session_url, params: { name: "dray", email_address: "dray@sked.com", password: password_digest }

    assert :success
  end
end
