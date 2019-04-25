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
    assert_text 'ใบสมัครรอดำเนินการโดยเจ้าหน้าที่'
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
    page.driver.browser.switch_to.alert.accept
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
    within(:xpath, '(//table)[1]') do
      click_on 'นัดหมาย', match: :first
    end
    within(:css, 'div#appoint') do
      fill_in 'appointment_date', with: 1.day.since
      fill_in 'appointment_remark', with: 'test appointment remark'
      click_on 'ทำการนัดหมาย'
    end
    assert_text 'test appointment remark'
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
    all(:xpath, '//input[@value="ok"]', visible: false).each do |ok|
      choose ok[:id], allow_label_click: true
    end
    click_on 'ยืนยันใบสมัคร'
    assert_text 'สร้างใบสมัครเรียบร้อย'
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
    all(:xpath, '//input[@value="ok"]', visible: false).each do |ok|
      choose ok[:id], allow_label_click: true
    end

    all(:xpath, '//input[@value="1" and @type="radio"]', visible: false).each do |ok|
      choose ok[:id], allow_label_click: true
    end
    choose 'application_visit_result_ดี', allow_label_click: true
    fill_in 'application[visit_comment]', with: 'test visit comment'
    click_on 'บันทึก'
    assert_text 'บันทึกผลการตรวจหน้างานเรียบร้อย'
    click_on 'ยืนยันผลการตรวจหน้างาน'
    page.driver.browser.switch_to.alert.accept
    assert_text 'ยืนยันผลการตรวจหน้างานเรียบร้อย'
    assert_text 'ใบสมัครที่ได้รับการตรวจหน้างานแล้ว'
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
    assert_text 'ใบสมัครรอดำเนินการโดยเจ้าหน้าที่'
    assert_text 'ใบสมัครดำเนินการเสร็จแล้ว'
    assert_text 'รอหลักฐานประกอบการประเมิน'
    click_on 'ส่งหลักฐาน', match: :first
    assert_text 'แนบหลักฐาน'
    # -- add evidence
    folder = 'example/evidence/'
    Dir.glob(folder+'*').each do |fn|
      filename = File.basename(fn)
      a = filename[0...(filename.index('.'))].to_i
      puts "attaching [#{fn}] ..."

      # cannot interact with <select/> element directly... use javascript instead
      page.execute_script("$('select#attachment_evidence_id').val(#{a})")
      attach_file('attachment_data', Rails.root.join(fn), make_visible: true)
      click_on 'ส่งไฟล์แนบ'
      assert_text 'แนบหลักฐาน'
      assert_text 'สำเร็จ'
    end
    click_on 'ยืนยันหลักฐาน'
    page.driver.browser.switch_to.alert.accept
    assert_text 'ได้ยืนยันการยื่นหลักฐานของใบสมัคร'
  end

  test "test offical evaluate application" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_offical.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ระบบประเมินผล'
    click_on 'ประเมิน'
    assert_text 'ใบสมัครรอข้อมูลการประเมิน'
    click_on 'ประเมิน'
    assert_text 'ยืนยันการประเมินผล'
    click_on id: 'confirm_button'
    page.driver.browser.switch_to.alert.accept
    assert_text 'ยังประเมินไม่ครบทุกหัวข้อ'
    all(:xpath, '//input[@value="1" and @type="radio"]', visible: false).each do |ok|
      choose ok[:id], allow_label_click: true
    end
    all(:xpath, '//input[starts-with(@name, "description") and @type="text"]', visible: false).each do |desc|
      fill_in desc[:id], with: 'perfect !!'
    end
    click_on 'บันทึก'
    assert_text 'บันทึกผลการประเมินเรียบร้อย'
    click_on id: 'confirm_button'
    page.driver.browser.switch_to.alert.accept
    assert_text 'ยืนยันผลการประเมินเรียบร้อย'
    assert_text 'ใบสมัครรอข้อมูลการประเมิน'
  end

  test "test offical evaluate award" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_offical.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ระบบตัดสินผล'
    click_on 'ตัดสินผล'
    assert_text 'ใบสมัครรอการตัดสินผล'
    click_on 'ตัดสินผล', match: :first
    assert_text 'การบันทึกผลการตัดสิน'
    choose 'result_ok', allow_label_click: true
    fill_in 'award_remark', with: 'pass award'
    click_on 'ยืนยันการตัดสินผล'
    page.driver.browser.switch_to.alert.accept
    assert_text 'บันทึกการตัดสินผลเรียบร้อย'
    assert_text 'ใบสมัครรอการตัดสินผล'
  end

  test "test licensee verify award" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_licensee.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    assert_text 'ใบสมัครรอการดำเนินการโดยผู้ประกอบการ'
    assert_text 'ใบสมัครรอดำเนินการโดยเจ้าหน้าที่'
    assert_text 'ใบสมัครดำเนินการเสร็จแล้ว'
    assert_text 'ได้มาตรฐาน Q-BUS' # should have application that awarded already
  end

  test "test licensee extend application" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_licensee.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    click_on 'ต่ออายุ'
    assert_text 'ต่ออายุใบสมัคร'
    click_on 'ต่ออายุ'
    assert_text 'ใบสมัครต่ออายุมาจากใบสมัครหมายเลข'
    attach_file('attachment[license_data]', Rails.root.join('example', 'identity', 'ใบอนุญาตประกอบการขนส่ง.jpg'), make_visible: true)
    attach_file('attachment[contract_data]', Rails.root.join('example', 'identity', 'สัญญาประกอบการรถขนส่งสาธารณะ.pdf'), make_visible: true)
    attach_file('attachment[signup_data]', Rails.root.join('example', 'identity', 'หนังสือยืนยันการเข้าร่วม Q-Bus.pdf'), make_visible: true)
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
    all(:xpath, '//input[@value="ok"]', visible: false).each do |ok|
      choose ok[:id], allow_label_click: true
    end
    click_on 'ยืนยันใบสมัคร'
    assert_text 'สร้างใบสมัครเรียบร้อย'
  end

  test "test anyone comment on public" do
    visit root_url
    assert_selector 'form.session' # root
    click_on 'ส่งข้อคิดเห็น'
    fill_in 'public_comment_route_no', with: 'test route no'
    fill_in 'public_comment_car_plate', with: 'test car plate'
    fill_in 'public_comment_licensee_name', with: 'test licensee name'
    fill_in 'public_comment_comment', with: 'test comment'
    fill_in 'public_comment_commenter_name', with: 'test commenter name'
    fill_in 'public_comment_commenter_contact', with: 'test commenter contact'
    fill_in 'public_comment_commenter_address', with: 'test commenter address'
    click_on 'ส่งข้อคิดเห็น'
    assert_text 'ข้อคิดเห็นของท่านไ้ดรับการบันทึกเรียบร้อยแล้ว'
    assert_selector 'form.session' # root
  end

  test "test admin create user" do
    visit root_url
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: @user_admin.email
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย' # root (logged in)
    visit process_dashboard_url
    click_on 'ผู้ใช้งาน'
    assert_text 'รายการผู้ใช้งาน'
    click_on 'เพิ่ม'
    assert_text 'เพิ่มผู้ใช้งาน'
    fill_in 'user_name', with: 'test new user'
    fill_in 'user_tel', with: 'test new tel'
    fill_in 'user_email', with: 'test999@gmail.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    all(:xpath, '//input[@type="checkbox"]', visible: false).each do |ok|
      check ok[:id], allow_label_click: true
    end
    click_on 'สร้างผู้ใช้งาน'
    assert_text 'สร้างผู้ใช้ใหม่เรียบร้อย'
    click_on 'ออกจากระบบ'
    assert_selector 'form.session' # root
    fill_in 'session[email]', with: 'test999@gmail.com'
    fill_in 'session[password]', with: 'testtest'
    click_on 'เข้าสู่ระบบ'
    assert_text 'เข้าสู่ระบบเรียบร้อย'
    click_on 'ออกจากระบบ'
    assert_selector 'form.session'
  end
end
