require "application_system_test_case"

class QbusTest < ApplicationSystemTestCase
  setup do
    Rails.application.load_seed
    @user_admin = User.find(1)
    @user_offical = User.find(2)
    @user_licensee = User.find(3)
  end

  test "test offical make visit report" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_offical.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ระบบงานนัดหมาย และ ตรวจหน้างาน'
    click_on 'นัดหมาย'
    assert_text 'ใบสมัครที่รอการตรวจหน้างาน'
    click_on 'บันทึกผลตรวจหน้างาน', match: :first
    assert_text 'การบันทึกผลการตรวจหน้างาน'
    fill_in 'application[visited_date]', with: 1.day.since
    fill_in 'application[visitor]', with: 'test application visitor'
    fill_in 'application[visitor_position]', with: 'test application visitor position'
    fill_in 'application[visitor_tel]', with: 'test application visitor tel'
    fill_in 'application[visitor_email]', with: 'visitor@example.com'
    fill_in 'application[visit_problem]', with: 'test visit problem'
    fill_in 'application[visit_problem_cause]', with: 'test visit problem cause'
    fill_in 'application[visit_tax_accrued]', with: '10'
    fill_in 'application[visit_tax_89]', with: '100'
    choose 'application_visit_car1_chassis_1', allow_label_click: true
    choose 'application_visit_car2_chassis_1', allow_label_click: true
    choose 'application_visit_car3_chassis_1', allow_label_click: true
    choose 'application_visit_car4_chassis_1', allow_label_click: true
    choose 'application_visit_car1_tire_1', allow_label_click: true
    choose 'application_visit_car2_tire_1', allow_label_click: true
    choose 'application_visit_car3_tire_1', allow_label_click: true
    choose 'application_visit_car4_tire_1', allow_label_click: true
    choose 'application_visit_car1_light_1', allow_label_click: true
    choose 'application_visit_car2_light_1', allow_label_click: true
    choose 'application_visit_car3_light_1', allow_label_click: true
    choose 'application_visit_car4_light_1', allow_label_click: true
    choose 'application_visit_car1_windshield_1', allow_label_click: true
    choose 'application_visit_car2_windshield_1', allow_label_click: true
    choose 'application_visit_car3_windshield_1', allow_label_click: true
    choose 'application_visit_car4_windshield_1', allow_label_click: true
    choose 'application_visit_result_ดี', allow_label_click: true
    fill_in 'application[visit_comment]', with: 'test visit comment'
    click_on 'บันทึก'
    assert_text 'บันทึกผลการตรวจหน้างานเรียบร้อย'
    click_on 'ยืนยันผลการตรวจหน้างาน'
    alert = page.driver.browser.switch_to.alert
    alert.accept
    assert_text 'ยืนยันผลการตรวจหน้างานเรียบร้อย'
    assert_text 'ใบสมัครที่ได้รับการตรวจหน้างานแล้ว'
  end
end
