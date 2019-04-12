require 'test_helper'

class ProcessControllerTest < ActionDispatch::IntegrationTest
  test "should get appointment_index" do
    get process_appointments_url
    assert_response :success
  end

  test "should get appointment_post" do
    @application = applications(:one)
    post appointment_visit_url(@application), params: { application: { id: 1, appointment_date: 1.week.ago, appointment_remark: 'appointed' } }
    assert_redirected_to appointment_visit_url(@application)
  end

  test "should get evaluation_index" do
    get process_evaluations_url
    assert_response :success
  end

  test "should get evaluation" do
    @application = applications(:one)
    get process_evaluation_url(@application)
    assert_response :success
  end

  test "should get award_index" do
    get process_awards_url
    assert_response :success
  end

  test "should get award" do
    @application = applications(:one)
    get process_award_url(@application)
    assert_response :success
  end

end
