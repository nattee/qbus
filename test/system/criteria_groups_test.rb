require "application_system_test_case"

class CriteriaGroupsTest < ApplicationSystemTestCase
  setup do
    @criteria_group = criteria_groups(:one)
  end

  test "visiting the index" do
    visit criteria_groups_url
    assert_selector "h1", text: "Criteria Groups"
  end

  test "creating a Criteria group" do
    visit criteria_groups_url
    click_on "New Criteria Group"

    click_on "Create Criteria group"

    assert_text "Criteria group was successfully created"
    click_on "Back"
  end

  test "updating a Criteria group" do
    visit criteria_groups_url
    click_on "Edit", match: :first

    click_on "Update Criteria group"

    assert_text "Criteria group was successfully updated"
    click_on "Back"
  end

  test "destroying a Criteria group" do
    visit criteria_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Criteria group was successfully destroyed"
  end
end
