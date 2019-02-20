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
      post licensees_url, params: { licensee: { car_count: @licensee.car_count, contact: @licensee.contact, contact_tel: @licensee.contact_tel, license_expire: @licensee.license_expire, license_no: @licensee.license_no, name: @licensee.name } }
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
    patch licensee_url(@licensee), params: { licensee: { car_count: @licensee.car_count, contact: @licensee.contact, contact_tel: @licensee.contact_tel, license_expire: @licensee.license_expire, license_no: @licensee.license_no, name: @licensee.name } }
    assert_redirected_to licensee_url(@licensee)
  end

  test "should destroy licensee" do
    assert_difference('Licensee.count', -1) do
      delete licensee_url(@licensee)
    end

    assert_redirected_to licensees_url
  end
end
