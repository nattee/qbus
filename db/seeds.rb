# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# purge ActiveStorage data
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }

Announcement.destroy_all
Evaluation.destroy_all
Attachment.destroy_all
Car.destroy_all
Application.destroy_all
Violation.destroy_all
Datafile.destroy_all
Route.destroy_all
Licensee.destroy_all
User.destroy_all
Criterium.destroy_all
CriteriaGroup.destroy_all
Evidence.destroy_all
CriteriumEvidence.destroy_all
PublicComment.destroy_all

User.create(id: 1, name: 'สมศักดิ์ (ดูแลระบบ)', email: 'test1@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 1, verifier: 1, surveyor: 0})
User.create(id: 2, name: 'สมปอง (เจ้าหน้าที่)', email: 'test2@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, verifier: 1, surveyor: 1, committee: 1, evaluator: 1})
User.create(id: 3, name: 'คุณสมชาย (ผู้ประกอบการ)', email: 'test3@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, licensee: 1})
User.create(id: 4, name: 'เจ้าหน้าที่ 1 ', email: 'o1@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, verifier: 1})
User.create(id: 5, name: 'เจ้าหน้าที่ 2 ', email: 'o2@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, surveyor: 1})
User.create(id: 6, name: 'เจ้าหน้าที่ 3 ', email: 'o3@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, evaluator: 1})
User.create(id: 7, name: 'เจ้าหน้าที่ 4 ', email: 'o4@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, committee: 1})

Licensee.create(id: 1, name: 'ผู้ประกอบการหนึ่ง', contact: 'สมหญิง', contact_tel: '0123456789')
Licensee.create(id: 2, name: 'ผู้ประกอบการสอง', contact: 'สมชาย', contact_tel: '0987654321')

Route.create(id: 1, start: 'เชียงใหม่', destination: 'กรุงเทพ', car_count: 10, route_type: 'รถเมล์', route_no: '1')
Route.create(id: 2, start: 'กรุงเทพ', destination: 'ชลบุรี', car_count: 10, route_type: 'รถสองแถว', route_no: '2')

Datafile.create(id: 1, name: 'ไฟล์ข้อมูลหนึ่ง', month_year: 1.year.ago, user: User.first() )
Datafile.create(id: 2, name: 'ไฟล์ข้อมูลสอง', month_year: 1.month.ago, user: User.last() )

Violation.create(id: 1, car: Car.first(), count: 10, month_year: Time.zone.now, datafile: Datafile.first())
Violation.create(id: 2, car: Car.last(), count: 20, month_year: Time.zone.now, datafile: Datafile.last())


# applying
Application.create(
  id: 1,
  state: 0,
  category: 1,
  user_id: 3
)
# registered
Application.create(
  id: 2,
  state: 1,
  category: 0,
  licensee: Licensee.first(),
  route: Route.first(),
  contact: 'ตัวแทน',
  contact_tel: '0594875632',
  contact_email: 'test3@gmail.com',
  license_no: "sdfsafa",
  license_expire: 1.year.since,
  car_count: 4,
  trip_count: 100,
  user_id: 3
)
# confirmed before appoint
Application.create(
  id: 3,
  state: 2,
  category: 0,
  licensee: Licensee.first(),
  route: Route.first(),
  contact: 'ตัวแทน',
  contact_tel: '0594875632',
  contact_email: 'test3@gmail.com',
  license_no: "sdfsafa",
  license_expire: 1.year.since,
  car_count: 4,
  trip_count: 100,
  confirmed_date: 1.week.ago,
  confirm_comment: 'ใบสมัครถูกต้อง',
  confirm_result: true,
  user_id: 3
)
# confirmed after appoint
Application.create(
  id: 4,
  state: 2,
  category: 0,
  licensee: Licensee.first(),
  route: Route.first(),
  contact: 'ตัวแทน',
  contact_tel: '0594875632',
  contact_email: 'test3@gmail.com',
  license_no: "sdfsafa",
  license_expire: 1.year.since,
  car_count: 4,
  trip_count: 100,
  confirmed_date: 1.week.ago,
  confirm_comment: 'ใบสมัครถูกต้อง',
  confirm_result: true,
  appointment_date: 1.day.ago,
  appointment_remark: 'test appointment',
  user_id: 3
)
# confirmed after appoint and visit
Application.create(
  id: 5,
  state: 2,
  category: 0,
  licensee: Licensee.first(),
  route: Route.first(),
  contact: 'ตัวแทน',
  contact_tel: '0594875632',
  contact_email: 'test3@gmail.com',
  license_no: "sdfsafa",
  license_expire: 1.year.since,
  car_count: 4,
  trip_count: 100,
  confirmed_date: 1.week.ago,
  confirm_comment: 'ใบสมัครถูกต้อง',
  confirm_result: true,
  appointment_date: 6.day.ago,
  appointment_remark: 'test appointment',
  visited_date: 6.day.ago,
  visited: true,
  visit_problem: 'none',
  visit_problem_cause: 'none',
  visit_tax_accrued: '123',
  visit_tax_89: '321',
  visit_result: 'visited',
  visit_comment: 'no comment',
  visit_car1_chassis: '1',
  visit_car1_tire: '1',
  visit_car1_light: '1',
  visit_car1_windshield: '1',
  visit_car2_chassis: '1',
  visit_car2_tire: '1',
  visit_car2_light: '1',
  visit_car2_windshield: '1',
  visit_car3_chassis: '1',
  visit_car3_tire: '1',
  visit_car3_light: '1',
  visit_car3_windshield: '1',
  visit_car4_chassis: '1',
  visit_car4_tire: '1',
  visit_car4_light: '1',
  visit_car4_windshield: '1',
  visitor: 'here i am',
  visitor_position: 'very high',
  visitor_tel: 'vintage phone',
  visitor_email: 'visitor@gmail.com',
  visited_confirm_date: 6.day.ago,
  user_id: 3
)
# submitted
Application.create(
  id: 6,
  state: 3,
  category: 0,
  licensee: Licensee.first(),
  route: Route.first(),
  contact: 'ตัวแทน',
  contact_tel: '0594875632',
  contact_email: 'test3@gmail.com',
  license_no: "sdfsafa",
  license_expire: 1.year.since,
  car_count: 4,
  trip_count: 100,
  confirmed_date: 1.week.ago,
  confirm_comment: 'ใบสมัครถูกต้อง',
  confirm_result: true,
  appointment_date: 6.day.ago,
  appointment_remark: 'test appointment',
  visited_date: 6.day.ago,
  visited: true,
  visit_problem: 'none',
  visit_problem_cause: 'none',
  visit_tax_accrued: '123',
  visit_tax_89: '321',
  visit_result: 'visited',
  visit_comment: 'no comment',
  visit_car1_chassis: '1',
  visit_car1_tire: '1',
  visit_car1_light: '1',
  visit_car1_windshield: '1',
  visit_car2_chassis: '1',
  visit_car2_tire: '1',
  visit_car2_light: '1',
  visit_car2_windshield: '1',
  visit_car3_chassis: '1',
  visit_car3_tire: '1',
  visit_car3_light: '1',
  visit_car3_windshield: '1',
  visit_car4_chassis: '1',
  visit_car4_tire: '1',
  visit_car4_light: '1',
  visit_car4_windshield: '1',
  visitor: 'here i am',
  visitor_position: 'very high',
  visitor_tel: 'vintage phone',
  visitor_email: 'visitor@gmail.com',
  visited_confirm_date: 6.day.ago,
  submitted_date: 6.day.ago,
  user_id: 3
)
# evaluated
Application.create(
  id: 7,
  state: 4,
  category: 0,
  licensee: Licensee.first(),
  route: Route.first(),
  contact: 'ตัวแทน',
  contact_tel: '0594875632',
  contact_email: 'test3@gmail.com',
  license_no: "sdfsafa",
  license_expire: 1.year.since,
  car_count: 4,
  trip_count: 100,
  confirmed_date: 1.week.ago,
  confirm_comment: 'ใบสมัครถูกต้อง',
  confirm_result: true,
  appointment_date: 6.day.ago,
  appointment_remark: 'test appointment',
  visited_date: 6.day.ago,
  visited: true,
  visit_problem: 'none',
  visit_problem_cause: 'none',
  visit_tax_accrued: '123',
  visit_tax_89: '321',
  visit_result: 'visited',
  visit_comment: 'no comment',
  visit_car1_chassis: '1',
  visit_car1_tire: '1',
  visit_car1_light: '1',
  visit_car1_windshield: '1',
  visit_car2_chassis: '1',
  visit_car2_tire: '1',
  visit_car2_light: '1',
  visit_car2_windshield: '1',
  visit_car3_chassis: '1',
  visit_car3_tire: '1',
  visit_car3_light: '1',
  visit_car3_windshield: '1',
  visit_car4_chassis: '1',
  visit_car4_tire: '1',
  visit_car4_light: '1',
  visit_car4_windshield: '1',
  visitor: 'here i am',
  visitor_position: 'very high',
  visitor_tel: 'vintage phone',
  visitor_email: 'visitor@gmail.com',
  visited_confirm_date: 6.day.ago,
  submitted_date: 6.day.ago,
  evaluation_result: '',
  evaluated_date: 5.day.ago,
  user_id: 3
)
# awarded
Application.create(
  id: 8,
  state: 5,
  category: 0,
  licensee: Licensee.first(),
  route: Route.first(),
  contact: 'ตัวแทน',
  contact_tel: '0594875632',
  contact_email: 'test3@gmail.com',
  license_no: "sdfsafa",
  license_expire: 1.year.since,
  car_count: 4,
  trip_count: 100,
  confirmed_date: 1.week.ago,
  confirm_comment: 'ใบสมัครถูกต้อง',
  confirm_result: true,
  appointment_date: 6.day.ago,
  appointment_remark: 'test appointment',
  visited_date: 6.day.ago,
  visited: true,
  visit_problem: 'none',
  visit_problem_cause: 'none',
  visit_tax_accrued: '123',
  visit_tax_89: '321',
  visit_result: 'visited',
  visit_comment: 'no comment',
  visit_car1_chassis: '1',
  visit_car1_tire: '1',
  visit_car1_light: '1',
  visit_car1_windshield: '1',
  visit_car2_chassis: '1',
  visit_car2_tire: '1',
  visit_car2_light: '1',
  visit_car2_windshield: '1',
  visit_car3_chassis: '1',
  visit_car3_tire: '1',
  visit_car3_light: '1',
  visit_car3_windshield: '1',
  visit_car4_chassis: '1',
  visit_car4_tire: '1',
  visit_car4_light: '1',
  visit_car4_windshield: '1',
  visitor: 'here i am',
  visitor_position: 'very high',
  visitor_tel: 'vintage phone',
  visitor_email: 'visitor@gmail.com',
  visited_confirm_date: 6.day.ago,
  submitted_date: 6.day.ago,
  evaluation_result: '',
  evaluated_date: 5.day.ago,
  awarded_date: 4.day.ago,
  award: 'ได้รับตราสัญลักษณ์',
  award_won: true,
  award_expire_date: 1.year.since,
  user_id: 3
)

Car.create(id: 1, plate: 'เลขทะเบียนรถหนึ่ง', chassis: 'เลขตัวรถหนึ่ง', application: Application.first(), car_type: 'รถเมล์', last_accident: 5.day.ago, last_accident_desc: 'ประสานงา')
Car.create(id: 2, plate: 'เลขทะเบียนรถสอง', chassis: 'เลขตัวรถสอง', application: Application.last(), car_type: 'รถสองแถว', last_accident: 2.week.ago, last_accident_desc: 'รถเสียกลางสี่แยก')

a1 = Announcement.create(
  id: 1,
  published: true,
  title: "การประชุมกลุ่มย่อยเกณฑ์มาตรฐานรถโดยสารสาธารณะ",
  description: "<p>กรมการขนส่งทางบกและสถาบันขนส่งแห่งจุฬาลงกรณ์มหาวิทยาลัย ได้จัดกิจกรรมประชุมกลุ่มย่อยเพื่อชี้แจงและรับฟังความคิดเห็นเกี่ยวกับ การประเมินเกณฑ์มาตรฐานรถโดยสารสาธารณะ </p> <p>โดยจัดขึ้นเมื่อวันจันทร์ที่ 7 มกราคม 2562 ณ ห้อง Orchid โรงแรมรามาการ์เด้นส์ </p>",
  user_id: 1
)

a2 = Announcement.create(
  id: 2,
  published: true,
  title: "การสัมภาษณ์ผู้ประกอบการเรื่องเกณฑ์การประเมิน",
  description: "<p>กรมการขนส่งทางบกและสถาบันขนส่งแห่งจุฬาลงกรณ์มหาวิทยาลัย ดำเนินการสัมภาษณ์ผู้ประกอบการเรื่องเกณฑ์การประเมินมาตรฐานรถโดยสาร (Q-Bus) เพื่อส่งเสริมความปลอดภัยในการใช้รถใช้ถนน</p> <p>โดยจัดขึ้นเมื่อวันที่ 27 กุมภาพันธ์ 2562</p>",
  user_id: 1
)

a1.main_attachment.attach io: File.open('example/announcement/ann1.jpg'), filename: 'ann1.jpg'
a2.main_attachment.attach io: File.open('example/announcement/ann2.jpg'), filename: 'ann2.jpg'

CriteriaGroup.create(id: 1, name: 'ข้อกำหนดด้านองค์กรและการบริหารจัดการ',group_weight: 12)
CriteriaGroup.create(id: 2, name: 'ข้อกำหนดด้านปฏิบัติงาน',group_weight: 12)
CriteriaGroup.create(id: 3, name: 'ข้อกำหนดด้านยานหาพนะ',group_weight: 15)
CriteriaGroup.create(id: 4, name: 'ข้อกำหนดด้านพนักงาน',group_weight: 21)
CriteriaGroup.create(id: 5, name: 'ข้อกำหนดด้านความปลอดภัย (วัดจากกระบวนการ)',group_weight: 18)
CriteriaGroup.create(id: 6, name: 'ข้อกำหนดด้านความปลอดภัย (วัดจากผลการดำเนินงาน)',group_weight: 22)
CriteriaGroup.create(id: 7, name: 'การประเมินตนเอง (สำหรับรถประจำทาง)',group_weight: 0)
CriteriaGroup.create(id: 8, name: 'การประเมินตนเอง',group_weight: 0)
CriteriaGroup.create(id: 9, name: 'การตรวจหน้างาน',group_weight: 0)

#
# ------------------ Criteria ---------------------------------------
#
Criterium.create(id: 1, number: 1, name: 'มีโครงสร้างการบริหารงานที่ชัดเจน', criteria_group_id: 1,weight: 3.75)
Criterium.create(id: 2, number: 2, name: 'มีการกำหนดนโยบายและวิสัยทัศน์ด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์อย่างชัดเจน', criteria_group_id: 1,weight: 3.75)
Criterium.create(id: 3, number: 3, name: 'มีการกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน', criteria_group_id: 1,weight: 3.75)
Criterium.create(id: 4, number: 4, name: 'มีช่องทางรับข้อเสนอแนะและข้อร้องเรียนจากลูกค้า และการประเมินระดับความพึงพอใจของลูกค้า', criteria_group_id: 1,weight: 3.75)
Criterium.create(id: 5, number: 5, name: 'ได้การรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ เช่น ISO 9001 หรือ ISO 14001 หรือรางวัลต่าง ๆ ที่เกี่ยวข้องกับการขนส่งหรือบริหารองค์กร', criteria_group_id: 1,weight: 3.75)


Criterium.create(id: 6, number: 1, name: 'มีการกำหนดขั้นตอนการปฏิบัติงานและคู่มือการปฏิบัติงาน', criteria_group_id: 2,weight: 3.75)
Criterium.create(id: 7, number: 2, name: 'มีการลงบันทึกสมุดพนักงานขับรถ/สมุดประจำรถ หรือบันทึก การปฏิบัติงานขนส่ง เพื่อเป็นหลักฐานการใช้รถขนส่งทุกครั้ง', criteria_group_id: 2,weight: 3.75)
Criterium.create(id: 8, number: 3, name: 'มีแผนการจัดตารางการเดินรถและการเข้างานของพนักงานที่ ชัดเจน', criteria_group_id: 2,weight: 3.75)
Criterium.create(id: 9, number: 4, name: 'มีการบันทึกผลการปฏิบัติงานที่แสดงประสิทธิผลการดำเนินงาน อย่างเหมาะสม', criteria_group_id: 2,weight: 3.75)
Criterium.create(id: 10, number: 5, name: 'มีการบันทึกข้อมูลปริมาณการใช้เชื้อเพลิงแบบรายคันและทุกคัน', criteria_group_id: 2,weight: 3.75)

Criterium.create(id: 11, number: 1, name: 'มีใบแสดงการตรวจสอบอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย', criteria_group_id: 3,weight: 5)
Criterium.create(id: 12, number: 2, name: 'มีระเบียบการบำรุงรักษายานพาหนะ และประวัติการซ่อมบำรุงของรถรายคัน', criteria_group_id: 3,weight: 5)
Criterium.create(id: 13, number: 3, name: 'มีใบแสดงการตรวจสอบความพร้อมและความสะอาดของรถโดยสารก่อนออกเดินทาง', criteria_group_id: 3,weight: 5)
Criterium.create(id: 14, number: 4, name: 'มีภาพถ่ายแสดงอุปกรณ์ส่วนควบต่าง ๆ ที่อยู่นอกเหนือข้อบังคับตามกฎหมาย', criteria_group_id: 3,weight: 5)


Criterium.create(id: 15, number: 1, name: 'มีระเบียบการสมัครงาน หรือ เอกสารบันทึกประวัติของพนักงานประจำรถ', criteria_group_id: 4,weight: 4)
Criterium.create(id: 16, number: 2, name: 'มีเอกสารแสดงกฎระเบียบและความรับผิดชอบของพนักงาน/ใบพรรณนาลักษณะงาน (JD) และแผนการสื่อสารให้พนักงานรับทราบ', criteria_group_id: 4,weight: 4)
Criterium.create(id: 17, number: 3, name: 'มีเอกสารระบุชั่วโมงทำงานและวันหยุดของพนักงานในแต่ละตำแหน่งหน้าที่', criteria_group_id: 4,weight: 4)
Criterium.create(id: 18, number: 4, name: 'มีเอกสารแสดงระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมายขององค์กร', criteria_group_id: 4,weight: 4)
Criterium.create(id: 19, number: 5, name: 'มีหลักฐานแสดงการตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่/แผนการสร้างเสริมสุขภาพของพนักงาน', criteria_group_id: 4,weight: 4)



Criterium.create(id: 20, number: 1, name: 'มีการบันทึกข้อมูลการเกิดอุบัติเหตุต่าง ๆ อย่างต่อเนื่อง', criteria_group_id: 5,weight: 15.0/7)
Criterium.create(id: 21, number: 2, name: 'มีคู่มือการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ ที่จำเป็นอย่างชัดเจน', criteria_group_id: 5,weight: 15.0/7)
Criterium.create(id: 22, number: 3, name: 'มีการจัดฝึกอบรมทักษะและประสบการณ์พนักงาน โดยเน้นด้านความปลอดภัย', criteria_group_id: 5,weight: 15.0/7)
Criterium.create(id: 23, number: 4, name: 'มีการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ', criteria_group_id: 5,weight: 15.0/7)
Criterium.create(id: 24, number: 5, name: 'มีแผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน', criteria_group_id: 5,weight: 15.0/7)
Criterium.create(id: 25, number: 6, name: 'มีหลักฐานการทำประกันภัยภาคสมัครใจเพิ่มเติม และมีมาตรการเยียวยาผู้เสียหายจากอุบัติเหตุ', criteria_group_id: 5,weight: 15.0/7)
Criterium.create(id: 26, number: 7, name: 'มีแนวทางป้องกันการเกิดอุบัติเหตุซ้ำซ้อน', criteria_group_id: 5,weight: 15.0/7)

Criterium.create(id: 27, number: 1, name: 'มีจำนวนครั้งที่ไม่แสดงตัวตนในระบบ GPS (ครั้ง)', criteria_group_id: 6,weight: 3)
Criterium.create(id: 28, number: 2, name: 'ระยะเวลาที่ใช้ความเร็วเกิน (นาที)', criteria_group_id: 6,weight: 3)
Criterium.create(id: 29, number: 3, name: 'ความเร็วสูงสุดที่ขับขี่ (km/h)', criteria_group_id: 6,weight: 3)
Criterium.create(id: 30, number: 4, name: 'ข้อมูลอุบัติเหตุของรถโดยสารสาธารณะ ทั่วประเทศ >> อุบัติเหตุร้ายแรง', criteria_group_id: 6,weight: 3)
Criterium.create(id: 31, number: 5, name: 'ข้อมูลอุบัติเหตุของรถโดยสารสาธารณะ ทั่วประเทศ ย้อนหลัง 12 เดือน (ข้อมูลตลอดปี 2561) >> อุบัติเหตุทั่วไป', criteria_group_id: 6,weight: 3)


Criterium.create(id: 32, number: 1, name: 'เดินรถตามเส้นทางตามที่กำหนดในใบอนุญาต', criteria_group_id: 7,weight: 0)
Criterium.create(id: 33, number: 2, name: 'จำนวนรถที่มีอยู่จริง ตรงตามเงื่อนไขจำนวนรถขั้นสูง-ขั้นต่ำ', criteria_group_id: 7,weight: 0)
Criterium.create(id: 34, number: 3, name: 'จำนวนเที่ยวเดินรถจริงเฉลี่ยต่อวัน ไม่น้อยกว่าจำนวนเที่ยวการเดินรถขั้นต่ำ', criteria_group_id: 7,weight: 0)
Criterium.create(id: 35, number: 4, name: 'เก็บอัตราค่าโดยสารตามที่กำหนด', criteria_group_id: 7,weight: 20)
Criterium.create(id: 36, number: 5, name: 'เวลาทำงานประจำวันในการประกอบการขนส่ง', criteria_group_id: 7,weight: 0)

Criterium.create(id: 37, number: 1, name: 'มีแผนการตรวจสภาพและบำรุงรักษา และดำเนินการอย่างเหมาะสม อย่างน้อยปีละ 2 ครั้ง', criteria_group_id: 8,weight: 20)
Criterium.create(id: 38, number: 2, name: 'การชำระภาษีรถทุกคัน', criteria_group_id: 8,weight: 0)
Criterium.create(id: 39, number: 3, name: 'มีการติดตั้ง GPS และเชื่อมต่อข้อมูลกับกรมการขนส่งทางบกทุกคัน', criteria_group_id: 8,weight: 0)
Criterium.create(id: 40, number: 4, name: 'มีการตรวจความพร้อมของพนักงานขับรถก่อนปฏิบัติงานทุกครั้ง (เช่น ระดับแอลกอฮอล์และสารเสพติด)', criteria_group_id: 8,weight: 0)


Criterium.create(id: 41, number: 1, name: 'เดินรถตามเส้นทางตามที่กำหนดในใบอนุญาตประกอบการเดินรถ', criteria_group_id: 9,weight: 0)
Criterium.create(id: 42, number: 2, name: 'จำนวนรถที่มีอยู่จริง ตรงตามเงื่อนไขจำนวนรถขั้นต่ำ-ขั้นสูง', criteria_group_id: 9,weight: 0)
Criterium.create(id: 43, number: 3, name: 'จำนวนเที่ยวเดินรถจริงเฉลี่ยต่อวัน ไม่น้อยกว่าจำนวนเที่ยวการเดินรถขั้นต่ำ', criteria_group_id: 9,weight: 0)
Criterium.create(id: 44, number: 4, name: 'เวลาเดินรถเที่ยวแรก-เที่ยวสุดท้ายตรงตามที่กำหนดในใบอนุญาตประกอบการขนส่ง', criteria_group_id: 9,weight: 0)
Criterium.create(id: 45, number: 5, name: 'เก็บค่าโดยสารตามอัตราที่กำหนด', criteria_group_id: 9,weight: 0)
Criterium.create(id: 46, number: 6, name: 'มีการชำระภาษีรถทุกคัน', criteria_group_id: 9,weight: 0)
Criterium.create(id: 47, number: 7, name: 'มีการติดตั้ง GPS และเชื่อมต่อข้อมูลกับกรมการขนส่งทางบกทุกคัน', criteria_group_id: 9,weight: 0)
Criterium.create(id: 48, number: 8, name: 'สถานที่เก็บ ซ่อม และบำรุงรักษารถโดยสาร มีความเหมาะสมและเพียงพอ', criteria_group_id: 9,weight: 0)
Criterium.create(id: 49, number: 9, name: 'มีการตรวจความพร้อมของพนักงานขับรถก่อนปฏิบัติงานทุกครั้ง (เช่น ระดับแอลกอฮอล์และสารเสพติด)', criteria_group_id: 9,weight: 0)
Criterium.create(id: 50, number: 10, name: 'กำหนดจุดพักรถและที่พักสำหรับพนักงานขับรถระหว่างเส้นทางขนส่งอย่างเหมาะสม', criteria_group_id: 9,weight: 0)

#
# --- example evaluation
#
Evaluation.create(application: Application.first(), evaluator: User.first(), evaluation_date: 1.month.ago, result: 1, description: 'ผ่าน', criterium: Criterium.first())
Evaluation.create(application: Application.last(), evaluator: User.first(), evaluation_date: 1.year.ago, result: 0, description: 'ไม่ผ่าน', criterium: Criterium.last())
Evaluation.create(application: Application.first(), evaluator: User.first(), evaluation_date: 1.month.ago, result: 1, description: 'ผ่าน', criterium_id: 29)
Evaluation.create(application: Application.first(), evaluator: User.first(), evaluation_date: 1.month.ago, result: 1, description: 'ผ่าน', criterium_id: 25)
Evaluation.create(application: Application.first(), evaluator: User.first(), evaluation_date: 1.month.ago, result: 0.5, description: 'ผ่าน', criterium_id: 11)

#
#--- evidence ----------
#
Evidence.create(id: 1, name: 'นโยบายองค์กรและการประกอบการ ')
Evidence.create(id: 2, name: 'โครงสร้างการบริหารองค์กร')
Evidence.create(id: 3, name: 'ผังกระบวนการทางธุรกิจ')
Evidence.create(id: 4, name: 'นโยบายเฉพาะด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์')
Evidence.create(id: 5, name: 'เอกสารกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน (KPI)')
Evidence.create(id: 6, name: 'เอกสารแสดงช่องทางการรับข้อเสนอแนะและข้อร้องเรียน')
Evidence.create(id: 7, name: 'ใบรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ หรือเกี่ยวข้องกับการขนส่งหรือบริหารองค์กร ')
Evidence.create(id: 8, name: 'คู่มือการปฏิบัติงาน อธิบายขั้นตอนกระบวนทำงาน')
Evidence.create(id: 9, name: 'สมุดพนักงาน หรือ สมุดประจำรถ หรือ บันทึกการปฏิบัติงานขนส่ง')
Evidence.create(id: 10, name: 'แผนการดำเนินงาน หรือ แผนการจัดตารางการเดินรถ และการเข้างานของพนักงาน')
Evidence.create(id: 11, name: 'รายงานสรุปผลการปฏิบัติงาน หรือ รายงานสำหรับผู้บริหารที่แสงดประสิทธิผลการดำเนินงาน')
Evidence.create(id: 12, name: 'บันทึกข้อมูลปริมาณการใช้เชื้อเพลิงแบบรายคันและทุกคัน')
Evidence.create(id: 13, name: 'ใบแสดงการตรวจสอบอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย')
Evidence.create(id: 14, name: 'ระเบียบการบำรุงรักษายานพาหนะและประวัติการซ่อมบำรุงของรถรายคัน')
Evidence.create(id: 15, name: 'ใบแสดงการตรวจสอบความพร้อมและความสะอาดของรถโดยสารก่อนออกเดินทาง')
Evidence.create(id: 16, name: 'ภาพถ่ายแสดงอุปกรณ์ส่วนควบต่าง ๆ ที่อยู่นอกเหนือข้อบังคับตามกฎหมาย')
Evidence.create(id: 17, name: 'ระเบียบการรับสมัครและรายงานการตรวจสอบประวัติของพนักงานประจำรถ')
Evidence.create(id: 18, name: 'เอกสารแสดงกฎระเบียบและความรับผิดชอบของพนักงาน หรือ ใบพรรณนาลักษณะงาน (JD) ')
Evidence.create(id: 19, name: 'เอกสารระบุชั่วโมงทำงานและวันหยุดของพนักงานในแต่ละตำแหน่งหน้าที่')
Evidence.create(id: 20, name: 'เอกสารแสดงระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมายขององค์กร')
Evidence.create(id: 21, name: 'หลักฐานแสดงการตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่ หรือ แผนการสร้างเสริมสุขภาพของพนักงาน')
Evidence.create(id: 22, name: 'เอกสารการบันทึกข้อมูลการเกิอุบัติเหตุต่าง ๆ อย่างต่อเนื่อง')
Evidence.create(id: 23, name: 'คู่มือการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ ที่จำเป็นอย่างชัดเจน')
Evidence.create(id: 24, name: 'คู่มือและภาพถ่ายของการฝึกอบรมทักษะพนักงานเพื่อยกระดับมาตรฐานด้านความปลอดภัย')
Evidence.create(id: 25, name: 'เอกสารการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ')
Evidence.create(id: 26, name: 'แผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน')
Evidence.create(id: 27, name: 'หลักฐานการทำประกันภัยภาคสมัครใจเพิ่มเติม')
Evidence.create(id: 28, name: 'หลักฐานการจดบันทึก ถ่ายรูป รวมถึงอธิบายสาเหตุที่เกิดอุบัติเหตุอย่างละเอียด')

#
#---- CriteriumEvidence
#
#
CriteriumEvidence.create(id: 1, criterium_id:1, evidence_id:1)
CriteriumEvidence.create(id: 2, criterium_id:1, evidence_id:2)
CriteriumEvidence.create(id: 3, criterium_id:1, evidence_id:3)
CriteriumEvidence.create(id: 4, criterium_id:2, evidence_id:4)
CriteriumEvidence.create(id: 5, criterium_id:3, evidence_id:5)
CriteriumEvidence.create(id: 6, criterium_id:4, evidence_id:6)
CriteriumEvidence.create(id: 7, criterium_id:5, evidence_id:7)
CriteriumEvidence.create(id: 8, criterium_id:6, evidence_id:8)
CriteriumEvidence.create(id: 9, criterium_id:7, evidence_id:9)
CriteriumEvidence.create(id: 10, criterium_id:8, evidence_id:10)
CriteriumEvidence.create(id: 11, criterium_id:9, evidence_id:11)
CriteriumEvidence.create(id: 12, criterium_id:10, evidence_id:12)
CriteriumEvidence.create(id: 13, criterium_id:11, evidence_id:13)
CriteriumEvidence.create(id: 14, criterium_id:12, evidence_id:14)
CriteriumEvidence.create(id: 15, criterium_id:13, evidence_id:15)
CriteriumEvidence.create(id: 16, criterium_id:14, evidence_id:16)
CriteriumEvidence.create(id: 17, criterium_id:15, evidence_id:17)
CriteriumEvidence.create(id: 18, criterium_id:16, evidence_id:18)
CriteriumEvidence.create(id: 19, criterium_id:17, evidence_id:19)
CriteriumEvidence.create(id: 20, criterium_id:18, evidence_id:20)
CriteriumEvidence.create(id: 21, criterium_id:19, evidence_id:21)
CriteriumEvidence.create(id: 22, criterium_id:20, evidence_id:22)
CriteriumEvidence.create(id: 23, criterium_id:21, evidence_id:23)
CriteriumEvidence.create(id: 24, criterium_id:22, evidence_id:24)
CriteriumEvidence.create(id: 25, criterium_id:23, evidence_id:25)
CriteriumEvidence.create(id: 26, criterium_id:24, evidence_id:26)
CriteriumEvidence.create(id: 27, criterium_id:25, evidence_id:27)
CriteriumEvidence.create(id: 28, criterium_id:26, evidence_id:28)

#
# -- add attachment to the first application
#
Application.all.each do |app|
  folder = 'example/identity/'
  filename = 'หนังสือยืนยันการเข้าร่วม Q-Bus.pdf'
  att = Attachment.new(
    filename: filename,
    application_id: app.id,
    attachment_type: :signup
  )
  att.data.attach io: File.open(folder+filename), filename: filename
  att.save

  filename = 'ใบอนุญาตประกอบการขนส่ง.jpg'
  att = Attachment.new(
    filename: filename,
    application_id: app.id,
    attachment_type: :license
  )
  att.data.attach io: File.open(folder+filename), filename: filename
  att.save

  filename = 'สัญญาประกอบการรถขนส่งสาธารณะ.pdf'
  att = Attachment.new(
    filename: filename,
    application_id: app.id,
    attachment_type: :contract
  )
  att.data.attach io: File.open(folder+filename), filename: filename
  att.save

  if app.state != 'applying'
    app.add_missing_evaluation
    # -- add evidence
    folder = 'example/evidence/'
    Dir.glob(folder+'*').each do |fn|
      filename = File.basename(fn)
      a = filename[0...(filename.index('.'))].to_i
      puts "adding [#{fn}] to the application [#{app.id}]"
      att = Attachment.new(
        filename: filename,
        application_id: app.id,
        attachment_type: :evidence,
        evidence_id: a
      )
      att.data.attach io: File.open(fn), filename: filename
      att.save
    end
  end
  # add evaluation result
  if app.state == 'evaluated' || app.state == 'awarded'
    app.evaluation_main.each do |ev|
      ev.result = 1
      ev.description = 'ok'
      ev.save
    end
  end

end

