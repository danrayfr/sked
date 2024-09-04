require "test_helper"

class Organizations::JoinCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in :danray
    @organization = organizations(:myspace)
  end

  test "create new join code" do
    assert_changes -> { @organization.reload.join_code } do
      post organization_join_code_url(@organization)
      assert_redirected_to users_url
    end
  end

  test "only owner or staff can generate new code" do
    sign_in :xavi
    post organization_join_code_url(@organization)
    assert_response :forbidden
  end
end
