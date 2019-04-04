require 'test_helper'

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get award" do
    get report_award_url
    assert_response :success
  end

end
