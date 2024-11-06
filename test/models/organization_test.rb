require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @organization = organizations(:myspace)
  end

  test "name should be present" do
    @organization.name = ""
    assert_not @organization.valid?
  end

  test "slug is generated from the name" do
    organization = Organization.create!(name: "Chatgenie", user: users(:david))
    assert_equal "chatgenie", organization.slug
  end
end
