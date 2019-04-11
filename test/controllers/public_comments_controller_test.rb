require 'test_helper'

class PublicCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @public_comment = public_comments(:one)
  end

  test "should get index" do
    get public_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_public_comment_url
    assert_response :success
  end

  test "should create public_comment" do
    assert_difference('PublicComment.count') do
      post public_comments_url, params: { public_comment: { route_no: 'a', car_plate: 'x', licensee_name: 'o', comment: 'abc', commenter_name: 'name', commenter_contact: 'contact', commenter_address: 'address' } }
    end

    assert_redirected_to public_comment_url(PublicComment.last)
  end

  test "should show public_comment" do
    get public_comment_url(@public_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_public_comment_url(@public_comment)
    assert_response :success
  end

  test "should update public_comment" do
    patch public_comment_url(@public_comment), params: { public_comment: { route_id: 2, car_id: 2, licensee_id: 2 } }
    assert_redirected_to public_comment_url(@public_comment)
  end

  test "should destroy public_comment" do
    assert_difference('PublicComment.count', -1) do
      delete public_comment_url(@public_comment)
    end

    assert_redirected_to public_comments_url
  end
end
