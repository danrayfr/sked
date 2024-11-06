require "test_helper"

class ServiceTest < ActiveSupport::TestCase
  def setup
    @service = services(:myspace_braces)
  end

  test "name should be present" do
    service = Service.new(name: "", organization: organizations(:myspace))

    assert_not service.valid?
    assert_includes service.errors[:name], "can't be blank"
  end

  test "should not allow duplicate service names within the same organization" do
    duplicate_service = Service.new(name: @service.name, organization: organizations(:myspace))

    assert_not duplicate_service.valid?
    assert_includes duplicate_service.errors[:name], "has already been taken"
  end

  test "should allow duplicate service name in different organization" do
    service = Service.new(name: @service.name, organization: organizations(:rg))

    assert service.valid?
  end

  test "should normalize the name after save" do
    service = Service.create!(name: "Dental Cleaning", organization: organizations(:rg))

    assert_equal service.name, "dental cleaning"
  end
end
