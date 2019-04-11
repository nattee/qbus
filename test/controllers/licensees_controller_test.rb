require 'test_helper'

class LicenseesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @licensee = licensees(:one)
  end

  test "should get index" do
    get licensees_url
    assert_response :success
  end

  test "should get new" do
    get new_licensee_url
    assert_response :success
  end

  test "should create licensee" do
    assert_difference('Licensee.count') do
      post licensees_url, params: { licensee: { name: 'test new', license_no: 'test new no', car_count: 'test new car count', contact: 'test new contact', contact_tel: 'test new contact tel', contact_email: 'test new contact email' } }
    end

    assert_redirected_to licensee_url(Licensee.last)
  end

  test "should show licensee" do
    get licensee_url(@licensee)
    assert_response :success
  end

  test "should get edit" do
    get edit_licensee_url(@licensee)
    assert_response :success
  end

  test "should update licensee" do
    patch licensee_url(@licensee), params: { licensee: { id: 1, name: 'test edit', license_no: 'test edit no', car_count: 'test edit car count', contact: 'test edit contact', contact_tel: 'test edit contact tel', contact_email: 'test edit contact email' } }
    assert_redirected_to licensee_url(@licensee)
  end

  test "should destroy licensee" do
    assert_difference('Licensee.count', -1) do
      delete licensee_url(@licensee)
    end

    assert_redirected_to licensees_url
  end
end
