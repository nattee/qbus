require "application_system_test_case"

class PublicCommentsTest < ApplicationSystemTestCase
  setup do
    @public_comment = public_comments(:one)
  end

  test "visiting the index" do
    visit public_comments_url
    assert_selector "h1", text: "Public Comments"
  end

  test "creating a Public comment" do
    visit public_comments_url
    click_on "New Public Comment"

    click_on "Create Public comment"

    assert_text "Public comment was successfully created"
    click_on "Back"
  end

  test "updating a Public comment" do
    visit public_comments_url
    click_on "Edit", match: :first

    click_on "Update Public comment"

    assert_text "Public comment was successfully updated"
    click_on "Back"
  end

  test "destroying a Public comment" do
    visit public_comments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Public comment was successfully destroyed"
  end
end
