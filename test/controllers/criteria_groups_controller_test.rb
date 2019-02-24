require 'test_helper'

class CriteriaGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @criteria_group = criteria_groups(:one)
  end

  test "should get index" do
    get criteria_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_criteria_group_url
    assert_response :success
  end

  test "should create criteria_group" do
    assert_difference('CriteriaGroup.count') do
      post criteria_groups_url, params: { criteria_group: {  } }
    end

    assert_redirected_to criteria_group_url(CriteriaGroup.last)
  end

  test "should show criteria_group" do
    get criteria_group_url(@criteria_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_criteria_group_url(@criteria_group)
    assert_response :success
  end

  test "should update criteria_group" do
    patch criteria_group_url(@criteria_group), params: { criteria_group: {  } }
    assert_redirected_to criteria_group_url(@criteria_group)
  end

  test "should destroy criteria_group" do
    assert_difference('CriteriaGroup.count', -1) do
      delete criteria_group_url(@criteria_group)
    end

    assert_redirected_to criteria_groups_url
  end
end
