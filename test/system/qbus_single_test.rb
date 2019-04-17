require "application_system_test_case"

class QbusTest < ApplicationSystemTestCase
  setup do
    Rails.application.load_seed
    @user_admin = User.find(1)
    @user_offical = User.find(2)
    @user_licensee = User.find(3)
  end

  test "test licensee send evidence" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_licensee.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ใบสมัครรอการดำเนินการโดยผู้ประกอบการ'
    assert_text 'ใบสมัครรอการตรวจสอบโดยเจ้าหน้าที่'
    assert_text 'ใบสมัครดำเนินการเสร็จแล้ว'
    assert_text 'รอหลักฐานประกอบการประเมิน'
    click_on 'ส่งหลักฐาน', match: :first
    # TODO: continue after issue #52 is fixed
  end
end
