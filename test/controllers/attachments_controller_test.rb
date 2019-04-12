require 'test_helper'

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attachment = attachments(:one)
  end

  test "should get index" do
    get attachments_url
    assert_response :success
  end

  test "should get new" do
    get new_attachment_url
    assert_response :success
  end

  test "should create attachment" do
    assert_difference('Attachment.count') do
      post attachments_url, params: { attachment: { filename: 'new file', application_id: 1, attachment_type: 1, evidence_id: 1, data: fixture_file_upload(Rails.root.join('test', 'fixtures', 'files', 'test.png'), 'image/png') } }
    end

    assert_redirected_to attachment_url(Attachment.last)
  end

  test "should show attachment" do
    get attachment_url(@attachment)
    assert_response :success
  end

  test "should get edit" do
    get edit_attachment_url(@attachment)
    assert_response :success
  end

  test "should update attachment" do
    patch attachment_url(@attachment), params: { attachment: { id: 1, filename: 'edit file', application_id: 2, attachment_type: 2, evidence_id: 2, data: fixture_file_upload(Rails.root.join('test', 'fixtures', 'files', 'test.png'), 'image/png') } }
    assert_redirected_to attachment_url(@attachment)
  end

  test "should destroy attachment" do
    assert_difference('Attachment.count', -1) do
      delete attachment_url(@attachment)
    end

    assert_redirected_to attachments_url
  end
end
