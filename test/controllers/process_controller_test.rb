require 'test_helper'

class ProcessControllerTest < ActionDispatch::IntegrationTest
  test "should get appointment_index" do
    get process_appointment_index_url
    assert_response :success
  end

  test "should get appointment_post" do
    get process_appointment_post_url
    assert_response :success
  end

  test "should get evaluation_index" do
    get process_evaluation_index_url
    assert_response :success
  end

  test "should get evaluation" do
    get process_evaluation_url
    assert_response :success
  end

  test "should get evaluation_post" do
    get process_evaluation_post_url
    assert_response :success
  end

  test "should get award_index" do
    get process_award_index_url
    assert_response :success
  end

  test "should get award" do
    get process_award_url
    assert_response :success
  end

  test "should get award_post" do
    get process_award_post_url
    assert_response :success
  end

end
