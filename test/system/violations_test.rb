require "application_system_test_case"

class ViolationsTest < ApplicationSystemTestCase
  setup do
    @violation = violations(:one)
  end

  test "visiting the index" do
    visit violations_url
    assert_selector "h1", text: "Violations"
  end

  test "creating a Violation" do
    visit violations_url
    click_on "New Violation"

    click_on "Create Violation"

    assert_text "Violation was successfully created"
    click_on "Back"
  end

  test "updating a Violation" do
    visit violations_url
    click_on "Edit", match: :first

    click_on "Update Violation"

    assert_text "Violation was successfully updated"
    click_on "Back"
  end

  test "destroying a Violation" do
    visit violations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Violation was successfully destroyed"
  end
end
