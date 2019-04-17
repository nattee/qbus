require "application_system_test_case"

class QbusTest < ApplicationSystemTestCase
  setup do
    Rails.application.load_seed
    @user_admin = User.find(1)
    @user_offical = User.find(2)
    @user_licensee = User.find(3)
  end

  test "test anyone visit root" do
    visit root_url
    assert_selector 'form.session'
  end

  test "test licensee visit dashboard" do
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
  end

  test "test offical visit dashboard" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_offical.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ใบสมัครรอการดำเนินการโดยเจ้าหน้าที่กรมการขนส่งทางบก'
  end

  test "test new user register" do
    visit root_url
    assert_selector 'form.session'
    click_on 'สมัครใช้งาน'
    fill_in 'user[name]', with: 'systemtest'
    fill_in 'user[tel]', with: '02183219847'
    fill_in 'user[email]', with: 'systemtest@example.com'
    fill_in 'user[password]', with: 'systemtest'
    fill_in 'user[password_confirmation]', with: 'systemtest'
    click_on 'สมัครใช้งาน'
    assert_selector 'form.session'
  end

  test "test licensee login logout" do
    visit root_url
    assert_selector 'form.session'
    fill_in 'session[email]', with: @user_licensee.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย'
    click_on 'ออกจากระบบ'
    assert_selector 'form.session'
  end

  test "test licensee apply" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_licensee.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    within(:css, 'div#left-menu') do
      click_on 'สมัครเข้าร่วมโครงการ'
    end
    assert_text 'เลือกหมวดการเดินรถ' # apply
    choose 'application_category_category1', allow_label_click: true
    click_on 'ต่อไป'
    assert_text 'กรอกข้อมูลพื้นฐาน' # apply_step1
    fill_in 'licensee[name]', with: 'new licensee'
    fill_in 'application[contact]', with: 'new application contact'
    fill_in 'application[contact_tel]', with: '0192019461'
    fill_in 'application[contact_email]', with: 'new_application@example.com'
    attach_file('attachment[license_data]', Rails.root.join('example', 'identity', 'ใบอนุญาตประกอบการขนส่ง.jpg'), make_visible: true)
    attach_file('attachment[contract_data]', Rails.root.join('example', 'identity', 'สัญญาประกอบการรถขนส่งสาธารณะ.pdf'), make_visible: true)
    attach_file('attachment[signup_data]', Rails.root.join('example', 'identity', 'หนังสือยืนยันการเข้าร่วม Q-Bus.pdf'), make_visible: true)
    fill_in 'application[license_no]', with: 'new license no'
    fill_in 'application[license_expire]', with: 1.day.ago
    fill_in 'route[route_no]', with: 'new route no'
    fill_in 'route[start]', with: 'new route start'
    fill_in 'route[destination]', with: 'new route destination'
    fill_in 'application[car_count]', with: '10'
    fill_in 'application[trip_count]', with: '100'
    click_on 'ไปยังขั้นตอนต่อไป'
    assert_text 'กรอกข้อมูลรถ' # apply_step2
    click_on 'เพิ่มรถ'
    within(:css, 'div#add-car') do
      fill_in 'province', with: 'new province'
      fill_in 'plate', with: 'new plate'
      fill_in 'brand', with: 'new brand'
      fill_in 'car_type', with: 'new car type'
      click_on 'เพิ่มรถ'
    end
    attach_file('attachment[b11_data]', Rails.root.join('example', 'identity', 'หนังสือยืนยันการเข้าร่วม Q-Bus.pdf'), make_visible: true)
    click_on 'ไปยังขั้นตอนต่อไป'
    assert_text 'ทำแบบประเมินตนเอง' #apply_step3
    all('input[value="ok"]').each do |ok|
      choose ok[:name]
    end
    click_on 'ยืนยันใบสมัคร'
    assert_text 'สร้างใบสมัครเรียบร้อย'
  end

  test "test offical confirm signup" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_offical.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ระบบงานตรวจสอบใบสมัคร' # dashboard
    click_on 'ตรวจสอบ'
    assert_text 'ใบสมัครรอการตรวจสอบความถูกต้อง' # registers
    click_on 'ตรวจ'
    assert_text 'ตรวจใบสมัคร' # registers (edit)
    choose 'result_ok', allow_label_click: true
    fill_in 'confirm_comment', with: 'test confirm comment'
    click_on 'ยืนยันผลการตรวจ'
    alert = page.driver.browser.switch_to.alert
    alert.accept
    assert_text 'ใบสมัครรอการตรวจสอบความถูกต้อง' # registers
    assert_text 'บันทึกผลการตรวจใบสมัคร'
    assert_text 'เรียบร้อย'
  end

  test "test offical make appointment" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_offical.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ระบบงานนัดหมาย และ ตรวจหน้างาน'
    click_on 'นัดหมาย'
    assert_text 'ใบสมัครที่ยังไม่ได้นัดหมาย'
    click_on 'นัดหมาย'
    within(:css, 'div#appoint') do
      fill_in 'appointment_date', with: 1.day.since
      fill_in 'appointment_remark', with: 'test appointment remark'
      click_on 'ทำการนัดหมาย'
    end
    assert_text 'test appointment remark'
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
