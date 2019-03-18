# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# purge ActiveStorage data
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }

Evaluation.destroy_all;
Attachment.destroy_all;
Car.destroy_all;
Application.destroy_all;
Violation.destroy_all;
Datafile.destroy_all;
Route.destroy_all;
Licensee.destroy_all;
User.destroy_all;
CriteriumAttachment.destroy_all;
Criterium.destroy_all;
CriteriaGroup.destroy_all;

User.create(id: 1, name: 'test1@gmail.com', email: 'test1@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 1, verifier: 1, surveyor: 0})
User.create(id: 2, name: 'test2@gmail.com', email: 'test2@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, verifier: 0, surveyor: 1})

Licensee.create(id: 1, name: 'ผู้ประกอบการหนึ่ง', license_no: 'หมายเลขผู้ประกอบการหนึ่ง', license_expire: 5.year.from_now, car_count: '100', contact: 'เจ้านายผู้ประกบอการ', contact_tel: '0123456789')
Licensee.create(id: 2, name: 'ผู้ประกอบการสอง', license_no: 'หมายเลขผู้ประกอบการสอง', license_expire: 5.year.from_now, car_count: '10', contact: 'ลูกน้องผู้ประกบอการ', contact_tel: '0987654321')

Route.create(id: 1, name: 'เส้นทางที่หนึ่ง', start: 'ป้ายแรก', destination: 'ป้ายสุดท้าย', car_count: 10, route_type: 'รถเมล์')
Route.create(id: 2, name: 'เส้นทางที่สอง', start: 'ป้ายแรกแรก', destination: 'ป้ายท้ายท้าย', car_count: 10, route_type: 'รถสองแถว')

Datafile.create(id: 1, name: 'ไฟล์ข้อมูลหนึ่ง', month_year: 1.year.ago, user: User.first() )
Datafile.create(id: 2, name: 'ไฟล์ข้อมูลสอง', month_year: 1.month.ago, user: User.last() )

Violation.create(id: 1, car: Car.first(), count: 10, month_year: Time.zone.now, datafile: Datafile.first())
Violation.create(id: 2, car: Car.last(), count: 20, month_year: Time.zone.now, datafile: Datafile.last())

Application.create(id: 1, number: 'หนึ่ง', user: User.first(), state: 0, licensee: Licensee.first(), route: Route.first(), appointment_date: 5.day.from_now, appointment_remark: 'กำหนดการนัดหมาย', appointment_user: User.last(), award: 'ถ้วยรางวัล', award_remark: 'พร้อมเงินโบนัส', contact: 'ผู้มารับรางวัล', contact_tel: '0192837465', category: 0, car_count: 10, trip_count: 1000)
Application.create(id: 2, number: 'สอง', user: User.last(), state: 0, licensee: Licensee.last(), route: Route.last(), appointment_date: 3.day.from_now, appointment_remark: 'นัดแล้วนะ', appointment_user: User.first(), award: 'รางวัลชมเชย', award_remark: 'พร้อมหนี้สิน', contact: 'ตัวแทน', contact_tel: '0594875632', category: 0, car_count: 4, trip_count: 100)

Car.create(id: 1, plate: 'เลขทะเบียนรถหนึ่ง', chassis: 'เลขตัวรถหนึ่ง', application: Application.first(), car_type: 'รถเมล์', last_accident: 5.day.ago, last_accident_desc: 'ประสานงา')
Car.create(id: 2, plate: 'เลขทะเบียนรถสอง', chassis: 'เลขตัวรถสอง', application: Application.last(), car_type: 'รถสองแถว', last_accident: 2.week.ago, last_accident_desc: 'รถเสียกลางสี่แยก')

CriteriaGroup.create(id: 1, name: 'ข้อกำหนดด้านองค์กรและการบริหารจัดการ',group_weight: 15)
CriteriaGroup.create(id: 2, name: 'ข้อกำหนดด้านปฏิบัติงาน',group_weight: 15)
CriteriaGroup.create(id: 3, name: 'ข้อกำหนดด้านยานหาพนะ',group_weight: 20)
CriteriaGroup.create(id: 4, name: 'ข้อกำหนดด้านพนักงาน',group_weight: 20)
CriteriaGroup.create(id: 5, name: 'ข้อกำหนดด้านความปลอดภัย',group_weight: 30)
CriteriaGroup.create(id: 6, name: 'ข้อกำหนดด้านความปลอดภัย',group_weight: 30)
CriteriaGroup.create(id: 7, name: 'ประเมินตัวเอง',group_weight: 30)

Criterium.create(id: 1, number: 1, name: 'มีการกำหนดอำนาจหน้าที่และความรับผิดชอบอย่างชัดเจนในแต่ละตำแหน่งขององค์กร (พนักงานรับทราบและสามารถปฏิบัติตามได้)', criteria_group_id: 1,weight: 20)
Criterium.create(id: 2, number: 2, name: 'มีการกำหนดนโยบายด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์ อย่างชัดเจน', criteria_group_id: 1,weight: 20)
Criterium.create(id: 3, number: 3, name: 'มีการกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน (เช่น อัตราการเกิดอุบัติเหตุ ความพึงพอใจของลูกค้า)', criteria_group_id: 1,weight: 20)
Criterium.create(id: 4, number: 4, name: 'มีการรับรองมาตรฐานสากล (ISO) หรือรางวัลต่าง ๆ (เช่น ISO 9001, ISO 14001)', criteria_group_id: 1,weight: 20)
Criterium.create(id: 5, number: 5, name: 'มีนโยบายกำกับขอบเขตความรับผิดชอบในการบริการอย่างชัดเจน (เช่น การรับประกันความเสียหายจากการเดินทาง)', criteria_group_id: 1,weight: 20)
Criterium.create(id: 6, number: 6, name: 'มีแนวทางในการพัฒนาองค์กรณ์', criteria_group_id: 1,weight: 20)
Criterium.create(id: 7, number: 7, name: 'มีแผนพัฒนาองค์กรในขั้นสูง (เช่น มีการใช้เครื่องมือปรับปรุงคุณภาพ TQM หรือ ไคเซ็น)', criteria_group_id: 1,weight: 20)
Criterium.create(id: 8, number: 8, name: 'เป็นสมาชิกและมีส่วนร่วมกับกิจกรรมของสภาวิชาชีพหรือสมาคมวิชาชีพ', criteria_group_id: 1,weight: 20)
Criterium.create(id: 9, number: 9, name: 'มีที่ตั้งสถานประกอบการ ที่จอดรถ และโรงซ่อมบำรุงมีความเหมาะสม (สามารถดำเนินงานได้ สะดวก และลดผลกระทบต่อชุมชน)', criteria_group_id: 1,weight: 20)


Criterium.create(id: 10, number: 1, name: 'มีการกำหนดขั้นตอนการปฏิบัติงานและคู่มือการปฏิบัติงานอย่างชัดเจน', criteria_group_id: 2,weight: 20)
Criterium.create(id: 11, number: 2, name: 'มีการลงบันทึกสมุดพนักงานขับรถ/สมุดประจำรถ เพื่อเป็นหลักฐานการใช้รถขนส่งทุกครั้ง', criteria_group_id: 2,weight: 20)
Criterium.create(id: 12, number: 3, name: 'มีแผนการจัดตารางการเดินรถและเวลาการทำงานของพนักงานที่ชัดเจน', criteria_group_id: 2,weight: 20)
Criterium.create(id: 13, number: 4, name: 'มีการบันทึกผลการปฏิบัติงานที่แสดงประสิทธิผลการดำเนินงานอย่างเหมาะสม', criteria_group_id: 2,weight: 20)
Criterium.create(id: 14, number: 5, name: 'มีกระบวนการเก็บข้อมูลและบันทึกเกี่ยวกับข้อผิดพลาดในการทำงาน', criteria_group_id: 2,weight: 20)
Criterium.create(id: 15, number: 6, name: 'มีการบันทึกข้อมูลปริมาณการใช้เชื้อเพลิงโดยรวม และรายคัน', criteria_group_id: 2,weight: 20)
Criterium.create(id: 16, number: 7, name: 'มีข้อมูลเกี่ยวกับผู้โดยสาร และประวัติการใช้บริการ', criteria_group_id: 2,weight: 20)
Criterium.create(id: 17, number: 8, name: 'มีการประเมินระดับความพึงพอใจของผู้โดยสาร', criteria_group_id: 2,weight: 20)
Criterium.create(id: 18, number: 9, name: 'มีการประชุมร่วมกับผู้โดยสาร เพื่อทราบความต้องการของผู้โดยสาร มีการบันทึกและปรับปรุงตามคำแนะนำ', criteria_group_id: 2,weight: 20)
Criterium.create(id: 19, number: 10, name: 'มีการตอบสนองข้อเสนอแนะจากผู้โดยสารและทบทวนสิ่งที่ไม่เป็นไปตามข้อเรียกร้องของผู้โดยสาร', criteria_group_id: 2,weight: 20)
Criterium.create(id: 20, number: 11, name: 'มีช่องทางรับข้อเสนอแนะจากผู้โดยสาร และบุคคลภายนอก', criteria_group_id: 2,weight: 20)



Criterium.create(id: 21, number: 1, name: 'มีความพร้อมของอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย (เช่น ประตูฉุกเฉิน ค้อนทุบกระจก ถังดับเพลิง)', criteria_group_id: 3,weight: 20)
Criterium.create(id: 22, number: 2, name: 'มีการจัดทำประวัติการใช้รถและประวัติการซ่อมบำรุงของรถรายคัน', criteria_group_id: 3,weight: 20)
Criterium.create(id: 23, number: 3, name: 'มีประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคลเพิ่มเติม นอกเหนือจากการทำประกันภัยภาคบังคับ', criteria_group_id: 3,weight: 20)
Criterium.create(id: 24, number: 4, name: 'มีการดูแลความสะอาดของรถโดยสารอย่างสม่ำเสมอ', criteria_group_id: 3,weight: 20)
Criterium.create(id: 25, number: 5, name: 'มีอุปกรณ์ส่วนควบที่อยู่นอกเหนือข้อบังคับตามกฎหมายต่าง ๆ (เช่น กล้องบันทึกภาพประจำรถ ฯลฯ อยู่ในสภาพที่สมบูรณ์พร้อมใช้งาน)', criteria_group_id: 3,weight: 20)
Criterium.create(id: 26, number: 6, name: 'มีการควบคุมความเร็วการขับขี่ เพื่อความปลอดภัยและประหยัดเชื้อเพลิง', criteria_group_id: 3,weight: 20)
Criterium.create(id: 27, number: 7, name: 'มีกฎระเบียบเข้มงวดในการติดเครื่องยนต์ขณะจอดรถเป็นเวลานาน', criteria_group_id: 3,weight: 20)


Criterium.create(id: 28, number: 1, name: 'มีการกำหนดขั้นตอนการรับสมัครพนักงาน บันทึก และเก็บรักษาประวัติพนักงานอย่างเหมาะสม', criteria_group_id: 4,weight: 20)
Criterium.create(id: 29, number: 2, name: 'มีระเบียบในการรับสมัครพนักงานขับรถ (เช่น การตรวจสอบประวัติ การทดสอบความสามารถ)', criteria_group_id: 4,weight: 20)
Criterium.create(id: 30, number: 3, name: 'มีการแสดงกฎระเบียบ บทลงโทษ และความรับผิดชอบของพนักงาน ประกาศให้พนักงานรับทราบอย่างทั่วถึง', criteria_group_id: 4,weight: 20)
Criterium.create(id: 31, number: 4, name: 'มีการกำหนดชั่วโมงการทำงาน วันหยุด', criteria_group_id: 4,weight: 20)
Criterium.create(id: 32, number: 5, name: 'มีแผนการฝึกอบรมทักษะและให้ประสบการณ์แก่พนักงาน', criteria_group_id: 4,weight: 20)
Criterium.create(id: 33, number: 6, name: 'มีระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี (เช่น มีการให้รางวัลพนักงานที่ ทำงานได้ดีเยี่ยม มีสวัสดิการพนักงาน เป็นต้น)', criteria_group_id: 4,weight: 20)
Criterium.create(id: 34, number: 7, name: 'มีโปรแกรมการสร้างเสริมสุขภาพของพนักงาน (เช่น การตรวจสุขภาพของพนักงานขับรถ)', criteria_group_id: 4,weight: 20)




Criterium.create(id: 35, number: 1, name: 'มีคู่มือสำหรับการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ', criteria_group_id: 5,weight: 20)
Criterium.create(id: 36, number: 2, name: 'มีการบันทึกข้อมูลรายละเอียดในการเกิดอุบัติเหตุต่าง ๆ', criteria_group_id: 5,weight: 20)
Criterium.create(id: 37, number: 3, name: 'มีแนวทางแก้ไขปรับปรุง และรายงานต่อหน่วยงานที่เกี่ยวข้องทราบ', criteria_group_id: 5,weight: 20)
Criterium.create(id: 38, number: 4, name: 'มีการวางแผนอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัยเป็นประจำ (เช่น มีการจัดอบรมพนังงานทุก 6 เดือน)', criteria_group_id: 5,weight: 20)
Criterium.create(id: 39, number: 5, name: 'มีการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ', criteria_group_id: 5,weight: 20)
Criterium.create(id: 40, number: 6, name: 'มีแผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน (การกำหนดให้มี Transport Safety Manager)', criteria_group_id: 5,weight: 20)



Criterium.create(id: 41, number: 1, name: 'มีการควบคุมความเร็วในการขับขี่รถอย่างเหมาะสม (สามารถตรวจสอบจากข้อมูลการใช้งานระบบบอกตำแหน่งบนโลก (GPS) ของกรมกาสรขนส่งทางบก)', criteria_group_id: 6,weight: 20)
Criterium.create(id: 42, number: 2, name: 'มีมาตรการเยียวยาผู้เสียหายและแนวทางป้องกันการเกิดอุบัติเหตุซ้ำซ้อน', criteria_group_id: 6,weight: 20)
Criterium.create(id: 43, number: 3, name: 'มีอัตราการเกิดอุบัติเหตุต่ำ(น้อยกว่า 1 ครั้งต่อ 1,000,000 กิโลเมตร)', criteria_group_id: 6,weight: 20)
Criterium.create(id: 44, number: 4, name: 'ไม่เกิดอุบัติรุนแรงในช่วง 1 ปี ที่ผ่ามา', criteria_group_id: 6,weight: 20)

Criterium.create(id: 45, number: 1, name: 'มีการกำหนดจุดพักรถและที่พักสำหรับพนักงานขับรถ (อย่างเหมาะสม)', criteria_group_id: 7,weight: 20)
Criterium.create(id: 46, number: 2, name: 'มีแผนการตรวจสอบและบำรุงรักษา (ตรวจสอบอย่างน้อยปีละ 2 ครั้ง)', criteria_group_id: 7,weight: 20)
Criterium.create(id: 47, number: 3, name: 'มีการติดตั้ง GPS และเชื่อมต่อข้อมูลกับกรมการขนส่งทางบก', criteria_group_id: 7,weight: 20)
Criterium.create(id: 48, number: 4, name: 'มีการตรวจความพร้อมของพนักงานขับรถก่อนปฏิบัติงานทุกครั้ง (เช่น การตรวจระดับแอลกอฮอล์ และสารเสพติด)', criteria_group_id: 7,weight: 20)

CriteriumAttachment.create(id: 1, name: 'นโยบายการประกอบการ', description: 'นโยบายการประกอบการ', required: true, criterium_id: 1)
CriteriumAttachment.create(id: 2, name: 'โครงสร้างบริหารองค์กร', description: 'โครงสร้างบริหารองค์กร', required: true, criterium_id: 1)
CriteriumAttachment.create(id: 3, name: 'ใบพรรณนาลักษณะงาน (JD)', description: 'ใบพรรณนาลักษณะงาน (JD)', required: true, criterium_id: 1)
CriteriumAttachment.create(id: 4, name: 'การสื่อสารให้พนักงานรับทราบ', description: 'การสื่อสารให้พนักงานรับทราบ', required: true, criterium_id: 1)
CriteriumAttachment.create(id: 5, name: 'นโยบายการประกอบการ', description: 'นโยบายการประกอบการ', required: true, criterium_id: 2)
CriteriumAttachment.create(id: 6, name: 'นโยบายเฉพาะด้าน', description: 'นโยบายเฉพาะด้าน', required: true, criterium_id: 2)
CriteriumAttachment.create(id: 7, name: 'การสื่อสารให้พนักงานรับทราบ', description: 'การสื่อสารให้พนักงานรับทราบ', required: true, criterium_id: 2)
CriteriumAttachment.create(id: 8, name: 'ตัวชี้วัดประสิทธิภาพ KPI', description: 'ตัวชี้วัดประสิทธิภาพ KPI', required: true, criterium_id: 3)
CriteriumAttachment.create(id: 9, name: 'หนังสือรับรองมาตรฐานสากล', description: 'หนังสือรับรองมาตรฐานสากล', required: true, criterium_id: 4)
CriteriumAttachment.create(id: 10, name: 'รางวัลทางธุรกิจต่าง ๆ', description: 'รางวัลทางธุรกิจต่าง ๆ', required: true, criterium_id: 4)
CriteriumAttachment.create(id: 11, name: 'นโยบายขอบเขตความรับผิดชอบ', description: 'นโยบายขอบเขตความรับผิดชอบ', required: true, criterium_id: 5)
CriteriumAttachment.create(id: 12, name: 'สัญญาในการว่าจ้าง', description: 'สัญญาในการว่าจ้าง', required: true, criterium_id: 5)
CriteriumAttachment.create(id: 13, name: 'ประกันภัยสำหรับผู้โดยสาร', description: 'ประกันภัยสำหรับผู้โดยสาร', required: true, criterium_id: 5)
CriteriumAttachment.create(id: 14, name: 'ผังกระบวนการทางธุรกิจ', description: 'ผังกระบวนการทางธุรกิจ', required: true, criterium_id: 6)
CriteriumAttachment.create(id: 15, name: 'ผังกระบวนการทางธุรกิจ', description: 'ผังกระบวนการทางธุรกิจ', required: true, criterium_id: 6)
CriteriumAttachment.create(id: 16, name: 'แผนการดำเนินการในระยะยาว', description: 'แผนการดำเนินการในระยะยาว', required: true, criterium_id: 6)
CriteriumAttachment.create(id: 17, name: 'หนังสือรับรองการเป็นสมาชิก', description: 'หนังสือรับรองการเป็นสมาชิก', required: true, criterium_id: 7)
CriteriumAttachment.create(id: 18, name: 'บัตรประจำตัวสมาชิก', description: 'บัตรประจำตัวสมาชิก', required: true, criterium_id: 7)
CriteriumAttachment.create(id: 19, name: 'รายงานการประชุมประจำปี', description: 'รายงานการประชุมประจำปี', required: true, criterium_id: 7)
CriteriumAttachment.create(id: 20, name: 'รายละเอียดการเข้าร่วมกิจกรรม', description: 'รายละเอียดการเข้าร่วมกิจกรรม', required: true, criterium_id: 7)
CriteriumAttachment.create(id: 21, name: 'รายละเอียดสถานที่ประกอบการ', description: 'รายละเอียดสถานที่ประกอบการ', required: true, criterium_id: 8)



CriteriumAttachment.create(id: 22, name: 'ขั้นตอนกระบวนการโดยสาร', description: 'ขั้นตอนกระบวนการโดยสาร', required: true, criterium_id: 10)
CriteriumAttachment.create(id: 23, name: 'ผังกระบวนการปฏิบัติงาน', description: 'ผังกระบวนการปฏิบัติงาน', required: true, criterium_id: 10)
CriteriumAttachment.create(id: 24, name: 'สมุดพนักงาน/สมุดประจำรถ', description: 'สมุดพนักงาน/สมุดประจำรถ', required: true, criterium_id: 11)
CriteriumAttachment.create(id: 25, name: 'บันทึกการปฏิบัติงานขนส่ง', description: 'บันทึกการปฏิบัติงานขนส่ง', required: true, criterium_id: 11)
CriteriumAttachment.create(id: 26, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 12)
CriteriumAttachment.create(id: 27, name: 'แผนการดำเนงาน', description: 'แผนการดำเนงาน', required: true, criterium_id: 12)
CriteriumAttachment.create(id: 28, name: 'การสรุปผลปฏิบัติงานขนส่ง', description: 'การสรุปผลปฏิบัติงานขนส่ง', required: true, criterium_id: 13)
CriteriumAttachment.create(id: 29, name: 'รายงานสำหรับผู้บริหาร', description: 'รายงานสำหรับผู้บริหาร', required: true, criterium_id: 13)
CriteriumAttachment.create(id: 30, name: 'ระเบียบการจัดการข้อผิดพลาด', description: 'ระเบียบการจัดการข้อผิดพลาด', required: true, criterium_id: 14)
CriteriumAttachment.create(id: 31, name: 'รายงานข้อผิดพลาด', description: 'รายงานข้อผิดพลาด', required: true, criterium_id: 14)
CriteriumAttachment.create(id: 32, name: 'มาตรการป้องกันข้อผิดพลาด', description: 'มาตรการป้องกันข้อผิดพลาด', required: true, criterium_id: 14)
CriteriumAttachment.create(id: 33, name: 'รายการปวัติข้อผิดพลาด', description: 'รายการปวัติข้อผิดพลาด', required: true, criterium_id: 14)
CriteriumAttachment.create(id: 34, name: 'รายงานสรุปการใช้เชื้อเพลิง', description: 'รายงานสรุปการใช้เชื้อเพลิง', required: true, criterium_id: 15)
CriteriumAttachment.create(id: 35, name: 'ฐานข้อมูลผู้โดยสาร', description: 'ฐานข้อมูลผู้โดยสาร', required: true, criterium_id: 16)
CriteriumAttachment.create(id: 36, name: 'ประวัติการใช้บริการ', description: 'ประวัติการใช้บริการ', required: true, criterium_id: 16)
CriteriumAttachment.create(id: 37, name: 'การสำรวจความพึงพอใจของผู้โดยสาร', description: 'การสำรวจความพึงพอใจของผู้โดยสาร', required: true, criterium_id: 17)
CriteriumAttachment.create(id: 38, name: 'รายงานการประชุม', description: 'รายงานการประชุม', required: true, criterium_id: 18)
CriteriumAttachment.create(id: 39, name: 'เอกสารประกอบการประชุม', description: 'เอกสารประกอบการประชุม', required: true, criterium_id: 18)
CriteriumAttachment.create(id: 40, name: 'การตอบสนองการรับข้อร้องเรียน', description: 'การตอบสนองการรับข้อร้องเรียน', required: true, criterium_id: 19)
CriteriumAttachment.create(id: 41, name: 'การรับข้อเสนอแนะ/ข้อร้องเรียน', description: 'การรับข้อเสนอแนะ/ข้อร้องเรียน', required: true, criterium_id: 20)



CriteriumAttachment.create(id: 42, name: 'ใบแสดงการตรวจสอบอุปกรณ์', description: 'ใบแสดงการตรวจสอบอุปกรณ์', required: true, criterium_id: 21)
CriteriumAttachment.create(id: 43, name: 'ระเบียบการบำรุงรักษายานพาหนะ', description: 'ระเบียบการบำรุงรักษายานพาหนะ', required: true, criterium_id: 22)
CriteriumAttachment.create(id: 44, name: 'ตารางการซ่อมบำรุง', description: 'ตารางการซ่อมบำรุง', required: true, criterium_id: 22)
CriteriumAttachment.create(id: 45, name: 'หลักฐานการสมัครประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคล', description: 'หลักฐานการสมัครประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคล', required: true, criterium_id: 23)
CriteriumAttachment.create(id: 46, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 24)
CriteriumAttachment.create(id: 47, name: 'กฎระเบียบการทำงาน', description: 'กฎระเบียบการทำงาน', required: true, criterium_id: 24)
CriteriumAttachment.create(id: 48, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 25)
CriteriumAttachment.create(id: 49, name: 'ใบแสดงอุปกรณ์', description: 'ใบแสดงอุปกรณ์', required: true, criterium_id: 25)
CriteriumAttachment.create(id: 50, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 26)
CriteriumAttachment.create(id: 51, name: 'แนวทางการควบคุม', description: 'แนวทางการควบคุม', required: true, criterium_id: 26)
CriteriumAttachment.create(id: 52, name: 'กฎระเบียบการทำงาน', description: 'กฎระเบียบการทำงาน', required: true, criterium_id: 26)
CriteriumAttachment.create(id: 53, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 27)
CriteriumAttachment.create(id: 54, name: 'แนวทางการควบคุม', description: 'แนวทางการควบคุม', required: true, criterium_id: 27)
CriteriumAttachment.create(id: 55, name: 'กฎระเบียบการทำงาน', description: 'กฎระเบียบการทำงาน', required: true, criterium_id: 27)



CriteriumAttachment.create(id: 56, name: 'ระเบียบการสมัครงาน', description: 'ระเบียบการสมัครงาน', required: true, criterium_id: 28)
CriteriumAttachment.create(id: 57, name: 'ระเบียบการรับสมัครงาน', description: 'ระเบียบการรับสมัครงาน', required: true, criterium_id: 29)
CriteriumAttachment.create(id: 58, name: 'วิธีปฏิบัติทดสอบความสามารถ', description: 'วิธีปฏิบัติทดสอบความสามารถ', required: true, criterium_id: 29)
CriteriumAttachment.create(id: 59, name: 'รายงานการตรวจสอบประวัติ', description: 'รายงานการตรวจสอบประวัติ', required: true, criterium_id: 29)
CriteriumAttachment.create(id: 60, name: 'เอกสารประวัติ', description: 'เอกสารประวัติ', required: true, criterium_id: 29)
CriteriumAttachment.create(id: 61, name: 'กฎระเบียบการทำงานของพนักงาน', description: 'กฎระเบียบการทำงานของพนักงาน', required: true, criterium_id: 30)
CriteriumAttachment.create(id: 62, name: 'ใบพรรณนาลักษณะงาน', description: 'ใบพรรณนาลักษณะงาน', required: true, criterium_id: 30)
CriteriumAttachment.create(id: 63, name: 'การสื่อสารให้พนักงานรับทราบ', description: 'การสื่อสารให้พนักงานรับทราบ', required: true, criterium_id: 30)
CriteriumAttachment.create(id: 64, name: 'เอกสารกำหนดชั่วโมงทำงานตามกฎหมาย', description: 'เอกสารกำหนดชั่วโมงทำงานตามกฎหมาย', required: true, criterium_id: 31)
CriteriumAttachment.create(id: 65, name: 'ระเบียบการจัดฝึกอบรม', description: 'ระเบียบการจัดฝึกอบรม', required: true, criterium_id: 32)
CriteriumAttachment.create(id: 66, name: 'แบบสำรวจความต้องการฝึกอบรม', description: 'แบบสำรวจความต้องการฝึกอบรม', required: true, criterium_id: 32)
CriteriumAttachment.create(id: 67, name: 'ประวัติการฝึกอบรม', description: 'ประวัติการฝึกอบรม', required: true, criterium_id: 32)
CriteriumAttachment.create(id: 68, name: 'รายละเอียดกิจกรรมเสริมการทำงาน', description: 'รายละเอียดกิจกรรมเสริมการทำงาน', required: true, criterium_id: 33)
CriteriumAttachment.create(id: 69, name: 'หลักฐานการดำเนินการ', description: 'หลักฐานการดำเนินการ', required: true, criterium_id: 33)
CriteriumAttachment.create(id: 70, name: 'หลักฐานการมอบรางวัล', description: 'หลักฐานการมอบรางวัล', required: true, criterium_id: 33)
CriteriumAttachment.create(id: 71, name: 'ใบรายงานการตรวจสุขภาพ', description: 'ใบรายงานการตรวจสุขภาพ', required: true, criterium_id: 34)



CriteriumAttachment.create(id: 72, name: 'คู่มือการจัดการเหตุฉุกเฉิน', description: 'คู่มือการจัดการเหตุฉุกเฉิน', required: true, criterium_id: 35)
CriteriumAttachment.create(id: 73, name: 'คู่มือประจำรถทุกคัน', description: 'คู่มือประจำรถทุกคัน', required: true, criterium_id: 35)
CriteriumAttachment.create(id: 74, name: 'รายงานการบันทึกอุบัติเหตุ', description: 'รายงานการบันทึกอุบัติเหตุ', required: true, criterium_id: 36)
CriteriumAttachment.create(id: 75, name: 'รายงานการฝึกอบรม', description: 'รายงานการฝึกอบรม', required: true, criterium_id: 37)
CriteriumAttachment.create(id: 76, name: 'ระเบียบการจัดฝึกอบรม', description: 'ระเบียบการจัดฝึกอบรม', required: true, criterium_id: 38)
CriteriumAttachment.create(id: 77, name: 'รายงานการฝึกอบรม', description: 'รายงานการฝึกอบรม', required: true, criterium_id: 38)
CriteriumAttachment.create(id: 78, name: 'แผนการดำเนินการ', description: 'แผนการดำเนินการ', required: true, criterium_id: 39)


CriteriumAttachment.create(id: 79, name: 'รายละเอียดการติดตามรถ', description: 'รายละเอียดการติดตามรถ', required: true, criterium_id: 41)
CriteriumAttachment.create(id: 80, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 42)
CriteriumAttachment.create(id: 81, name: 'แนวทางการควบคุม', description: 'แนวทางการควบคุม', required: true, criterium_id: 42)
CriteriumAttachment.create(id: 82, name: 'กฎระเบียบการทำงาน', description: 'กฎระเบียบการทำงาน', required: true, criterium_id: 42)
CriteriumAttachment.create(id: 83, name: 'หลักฐานบันทึกการเกิดอุบัติเหตุ', description: 'หลักฐานบันทึกการเกิดอุบัติเหตุ', required: true, criterium_id: 43)
CriteriumAttachment.create(id: 84, name: 'หลักฐานบันทึกการเกิดอุบัติเหตุ', description: 'หลักฐานบันทึกการเกิดอุบัติเหตุ', required: true, criterium_id: 44)



CriteriumAttachment.create(id: 85, name: 'คู่มือปฏิบัติงานขนส่ง', description: 'คู่มือปฏิบัติงานขนส่ง', required: true, criterium_id: 45)
CriteriumAttachment.create(id: 86, name: 'รายการสถานที่จุดพักรถที่กำหนด', description: 'รายการสถานที่จุดพักรถที่กำหนด', required: true, criterium_id: 45)
CriteriumAttachment.create(id: 87, name: 'ตารางการตรวจสุขภาพพนักงาน', description: 'ตารางการตรวจสุขภาพพนักงาน', required: true, criterium_id: 46)
CriteriumAttachment.create(id: 88, name: 'รายงานผลการตรวจสุขภาพ', description: 'รายงานผลการตรวจสุขภาพ', required: true, criterium_id: 46)
CriteriumAttachment.create(id: 89, name: 'รายละเอียดการติดตามรถ', description: 'รายละเอียดการติดตามรถ', required: true, criterium_id: 47)
CriteriumAttachment.create(id: 90, name: 'ระเบียบการบำรุงรักษายานพาหนะ', description: 'ระเบียบการบำรุงรักษายานพาหนะ', required: true, criterium_id: 48)
CriteriumAttachment.create(id: 91, name: 'ตารางการซ่อมบำรุง', description: 'ตารางการซ่อมบำรุง', required: true, criterium_id: 48)

Evaluation.create(id: 1, application: Application.first(), evaluator: 'ผู้ตรวรการ', evaluation_date: 1.month.ago, result: true, description: 'ผ่าน', criterium: Criterium.first())
Evaluation.create(id: 2, application: Application.last(), evaluator: 'ผู้คุม', evaluation_date: 1.year.ago, result: false, description: 'ไม่ผ่าน', criterium: Criterium.last())
