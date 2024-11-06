require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @organization = organizations(:myspace)
  end

  test "get user current organization on index" do
    sign_in :danray
    get root_url
    assert_equal users(:danray).organization, @organization
  end

  test "redirect to new if user current organization is blank" do
    sign_in :xavier
    get root_url
    assert_not users(:xavier).organization

    assert_redirected_to new_organization_url
  end
end
