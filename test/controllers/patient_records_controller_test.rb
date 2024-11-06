require "test_helper"

class PatientRecordsControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in :danray
    @uid = organizations(:myspace).uid
  end

  test "index lists the organization patient records" do
    get slugged_organization_patient_records_url(@uid)

    assert_response :success
    assert_select "title", "Organization | Patient Records"
    assert_select "h1", text: "Patient Records"
  end
end
