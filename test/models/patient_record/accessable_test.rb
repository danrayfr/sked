require "test_helper"

class PatientRecord::AccessableTest < ActiveSupport::TestCase
  def setup
    @organization = organizations(:myspace)
    @owner = users(:danray)
  end

  test "update_access grants owners editors access" do
    record = PatientRecord.create(name: "Dan Ray Rollan", email_address: "danray@sked.com", date: Date.today, organization: @organization)

    assert_equal record.name, "Dan Ray Rollan"
  end
end
