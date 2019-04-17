require "application_system_test_case"

class QbusTest < ApplicationSystemTestCase
  setup do
    @user_admin = users(:one)
    @user_offical = users(:two)
    @user_licensee = users(:three)
    Rails.application.load_seed
  end

  test "offical dashboard" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_offical.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ใบสมัครรอการดำเนินการโดยเจ้าหน้าที่กรมการขนส่งทางบก'
  end

end
