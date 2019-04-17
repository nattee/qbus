require "application_system_test_case"

class QbusTest < ApplicationSystemTestCase
  setup do
    @user_admin = users(:one)
    @user_offical = users(:two)
    @user_licensee = users(:three)
  end

  test "visiting root" do
    visit root_url
    assert_selector 'form.session'
  end

  test "register" do
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

  test "login logout" do
    visit root_url
    assert_selector 'form.session'
    fill_in 'session[email]', with: @user_licensee.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย'
    click_on 'ออกจากระบบ'
    assert_selector 'form.session'
  end

  test "apply" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_licensee.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    within(:css, 'div#left-menu') do
      click_on 'สมัครเข้าร่วมโครงการ'
    end
    assert_text 'สมัครเข้าร่วมโครงการ Q-BUS' # apply
    choose id: 'application_category_category1', allow_label_click: true
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

  test "licensee dashboard" do
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
