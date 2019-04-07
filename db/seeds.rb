# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# purge ActiveStorage data
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }

Evaluation.destroy_all
Attachment.destroy_all
Car.destroy_all
Application.destroy_all
Violation.destroy_all
Datafile.destroy_all
Route.destroy_all
Licensee.destroy_all
User.destroy_all
CriteriumAttachment.destroy_all
Criterium.destroy_all
CriteriaGroup.destroy_all
Evidence.destroy_all
CriteriumEvidence.destroy_all
PublicComment.destroy_all

User.create(id: 1, name: 'สมศักดิ์ (ดูแลระบบ)', email: 'test1@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 1, verifier: 1, surveyor: 0})
User.create(id: 2, name: 'สมปอง (เจ้าหน้าที่)', email: 'test2@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, verifier: 1, surveyor: 1, committee: 1, evaluator: 1})
User.create(id: 3, name: 'คุณสมชาย (ผู้ประกอบการ)', email: 'test3@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, licensee: 1})

Licensee.create(id: 1, name: 'ผู้ประกอบการหนึ่ง', contact: 'สมหญิง', contact_tel: '0123456789')
Licensee.create(id: 2, name: 'ผู้ประกอบการสอง', contact: 'สมชาย', contact_tel: '0987654321')

Route.create(id: 1, start: 'เชียงใหม่', destination: 'กรุงเทพ', car_count: 10, route_type: 'รถเมล์', route_no: 'no1')
Route.create(id: 2, start: 'กรุงเทพ', destination: 'ชลบุรี', car_count: 10, route_type: 'รถสองแถว', route_no: 'no2')

Datafile.create(id: 1, name: 'ไฟล์ข้อมูลหนึ่ง', month_year: 1.year.ago, user: User.first() )
Datafile.create(id: 2, name: 'ไฟล์ข้อมูลสอง', month_year: 1.month.ago, user: User.last() )

Violation.create(id: 1, car: Car.first(), count: 10, month_year: Time.zone.now, datafile: Datafile.first())
Violation.create(id: 2, car: Car.last(), count: 20, month_year: Time.zone.now, datafile: Datafile.last())

Application.create(id: 1, number: 'หนึ่ง', user: User.first(), state: 0, licensee: Licensee.first(), route: Route.first(), appointment_date: 5.day.from_now, appointment_remark: 'กำหนดการนัดหมาย', appointment_user: User.last(), award: 'ถ้วยรางวัล', award_remark: 'พร้อมเงินโบนัส', contact: 'ผู้มารับรางวัล', contact_tel: '0192837465', category: 0, car_count: 10, trip_count: 1000)
Application.create(id: 2, number: 'สอง', user: User.last(), state: 0, licensee: Licensee.last(), route: Route.last(), appointment_date: 3.day.from_now, appointment_remark: 'นัดแล้วนะ', appointment_user: User.first(), award: 'รางวัลชมเชย', award_remark: 'พร้อมหนี้สิน', contact: 'ตัวแทน', contact_tel: '0594875632', category: 0, car_count: 4, trip_count: 100)

Car.create(id: 1, plate: 'เลขทะเบียนรถหนึ่ง', chassis: 'เลขตัวรถหนึ่ง', application: Application.first(), car_type: 'รถเมล์', last_accident: 5.day.ago, last_accident_desc: 'ประสานงา')
Car.create(id: 2, plate: 'เลขทะเบียนรถสอง', chassis: 'เลขตัวรถสอง', application: Application.last(), car_type: 'รถสองแถว', last_accident: 2.week.ago, last_accident_desc: 'รถเสียกลางสี่แยก')

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
Criterium.create(id: 2, number: 2, name: 'มีการกำหนดนโยบายและวิสัยทัศน์ ด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์อย่างชัดเจน', criteria_group_id: 1,weight: 3.75)
Criterium.create(id: 3, number: 3, name: 'มีการกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน', criteria_group_id: 1,weight: 3.75)
Criterium.create(id: 4, number: 4, name: 'มีช่องทางรับข้อเสนอแนะและข้อร้องเรียนจากลูกค้า และการประเมินระดับความพึงพอใจของลูกค้า', criteria_group_id: 1,weight: 3.75)
Criterium.create(id: 5, number: 5, name: 'ได้การรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ เช่น ISO 9001 ISO 14001 หรือรางวัลต่าง ๆ', criteria_group_id: 1,weight: 3.75)

Criterium.create(id: 6, number: 1, name: 'มีการกำหนดขั้นตอนการปฏิบัติงานและคู่มือการปฏิบัติงาน', criteria_group_id: 2,weight: 3.75)
Criterium.create(id: 7, number: 2, name: 'มีการลงบันทึกสมุดพนักงานขับรถ/สมุดประจำรถ หรือบันทึกการปฏิบัติงานขนส่ง เพื่อเป็นหลักฐานการใช้รถขนส่งทุกครั้ง', criteria_group_id: 2,weight: 3.75)
Criterium.create(id: 8, number: 3, name: 'มีแผนการจัดตารางการเดินรถและการเข้างานของพนักงานที่ชัดเจน', criteria_group_id: 2,weight: 3.75)
Criterium.create(id: 9, number: 4, name: 'มีการบันทึกผลการปฏิบัติงานที่แสดงประสิทธิผลการดำเนินงานอย่างเหมาะสม', criteria_group_id: 2,weight: 3.75)
Criterium.create(id: 10, number: 5, name: 'มีการบันทึกข้อมูลปริมาณการใช้เชื้อเพลิงโดยรวมทั้งหมู่ยานพาหนะและรายคัน', criteria_group_id: 2,weight: 3.75)

Criterium.create(id: 11, number: 1, name: 'มีความพร้อมของอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย', criteria_group_id: 3,weight: 4)
Criterium.create(id: 12, number: 2, name: 'มีการจัดทำประวัติการใช้รถและประวัติการซ่อมบำรุงของรถรายคัน', criteria_group_id: 3,weight: 4)
Criterium.create(id: 13, number: 3, name: 'มีประกันภัยภาคสมัครใจหรือประกันภัยส่วนบุคคลเพิ่มเติม', criteria_group_id: 3,weight: 4)
Criterium.create(id: 14, number: 4, name: 'มีการดูแลความสะอาดของรถโดยสารอย่างสม่ำเสมอ', criteria_group_id: 3,weight: 4)
Criterium.create(id: 15, number: 5, name: 'อุปกรณ์ส่วนควบที่อยู่นอกเหนือข้อบังคับตามกฎหมายต่าง ๆ', criteria_group_id: 3,weight: 4)

Criterium.create(id: 16, number: 1, name: 'มีการกำหนดขั้นตอนการรับสมัครพนักงาน บันทึก และเก็บรักษาประวัติพนักงานอย่างเหมาะสม', criteria_group_id: 4,weight: 20.0/7)
Criterium.create(id: 17, number: 2, name: 'มีระเบียบการรับสมัครและการตรวจสอบประวัติพนักงานขับรถ', criteria_group_id: 4,weight: 20.0/7)
Criterium.create(id: 18, number: 3, name: 'มีการแสดงกฎระเบียบและความรับผิดชอบของพนักงาน รวมถึงบทลงโทษ และประกาศให้พนักงานรับทราบอย่างทั่วถึง', criteria_group_id: 4,weight: 20.0/7)
Criterium.create(id: 19, number: 4, name: 'มีการวางแผนกำหนดชั่วโมงทำงาน วันหยุด และดำเนินการอย่างเหมาะสม', criteria_group_id: 4,weight: 20.0/7)
Criterium.create(id: 20, number: 5, name: 'มีแผนการฝึกอบรมทักษะและประสบการณ์พนักงาน และดำเนินการอย่างเหมาะสม', criteria_group_id: 4,weight: 20.0/7)
Criterium.create(id: 21, number: 6, name: 'มีระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมายขององค์กร', criteria_group_id: 4,weight: 20.0/7)
Criterium.create(id: 22, number: 7, name: 'มีการสร้างเสริมสุขภาพของพนักงาน ตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่ มีการบันทึกและเก็บรักษาผลอย่างเป็นระบบ', criteria_group_id: 4,weight: 20.0/7)

Criterium.create(id: 23, number: 1, name: 'มีคู่มือการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ ที่จำเป็นอย่างชัดเจน', criteria_group_id: 5,weight: 2.5)
Criterium.create(id: 24, number: 2, name: 'มีการบันทึกข้อมูลการเกิดอุบัติเหตุต่าง ๆ อย่างต่อเนื่อง', criteria_group_id: 5,weight: 2.5)
Criterium.create(id: 25, number: 3, name: 'มีการวางแผนอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัย เป็นประจำ', criteria_group_id: 5,weight: 2.5)
Criterium.create(id: 26, number: 4, name: 'มีการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ', criteria_group_id: 5,weight: 2.5)
Criterium.create(id: 27, number: 5, name: 'มีแผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน', criteria_group_id: 5,weight: 2.5)
Criterium.create(id: 28, number: 6, name: 'มีมาตรการเยียวยาผู้เสียหายและแนวทางป้องกันการเกิดอุบัติเหตุซ้ำซ้อน', criteria_group_id: 5,weight: 2.5)

Criterium.create(id: 29, number: 1, name: 'จำนวนครั้งในการไม่แสดงตัวตน (ครั้ง) ไม่เกินค่าที่กำหนด', criteria_group_id: 6,weight: 2.5)
Criterium.create(id: 30, number: 2, name: 'ระยะเวลาที่ใช้ความเร็วเกิน (นาที) ไม่เกินค่าที่กำหนด', criteria_group_id: 6,weight: 2.5)
Criterium.create(id: 31, number: 3, name: 'ความเร็วสูงสุดที่ขับขี่ (กม./ชม.) ไม่เกินค่าที่กำหนด', criteria_group_id: 6,weight: 2.5)
Criterium.create(id: 32, number: 4, name: 'ความเร็วที่ขับเกินกฎหมายกำหนดโดยเฉลี่ย (กม./ชม.) ไม่เกินค่าที่กำหนด', criteria_group_id: 6,weight: 2.5)
Criterium.create(id: 33, number: 5, name: 'จำนวนครั้งในการเกิดอุบัติเหตุร้ายแรง ของรถโดยสารสาธารณะทั้งประเทศ ย้อนหลัง 12 เดือน ', criteria_group_id: 6,weight: 2.5)
Criterium.create(id: 34, number: 6, name: 'จำนวนครั้งในการเกิดอุบัติเหตุทั่วไป ของรถโดยสารสาธารณะทั้งประเทศ ย้อนหลัง 12 เดือน ', criteria_group_id: 6,weight: 2.5)

Criterium.create(id: 35, number: 1, name: 'เดินรถตามเส้นทางตามที่กำหนดในใบอนุญาตประกอบการเดินรถ', criteria_group_id: 7,weight: 0)
Criterium.create(id: 36, number: 2, name: 'จำนวนรถที่มีอยู่จริง ตรงตามเงื่อนไขจำนวนรถขั้นต่ำ-ขั้นสูง', criteria_group_id: 7,weight: 0)
Criterium.create(id: 37, number: 3, name: 'จำนวนเที่ยวเดินรถจริงเฉลี่ยต่อวัน ไม่น้อยกว่าจำนวนเที่ยวการเดินรถขั้นต่ำ', criteria_group_id: 7,weight: 0)
Criterium.create(id: 38, number: 4, name: 'เก็บค่าโดยสารตามอัตราที่กำหนด', criteria_group_id: 7,weight: 0)
Criterium.create(id: 39, number: 5, name: 'เวลาเดินรถตรงตามที่กำหนดในใบอนุญาตประกอบการขนส่ง', criteria_group_id: 7,weight: 0)

Criterium.create(id: 40, number: 1, name: 'มีแผนการตรวจสภาพและบำรุงรักษาและดำเนินการอย่างเหมาะสม', criteria_group_id: 8,weight: 0)
Criterium.create(id: 41, number: 2, name: 'มีการชำระภาษีรถทุกคัน', criteria_group_id: 8,weight: 0)
Criterium.create(id: 42, number: 3, name: 'มีการติดตั้ง GPS และเชื่อมต่อข้อมูลกับกรมการขนส่งทางบกทุกคัน', criteria_group_id: 8,weight: 0)
Criterium.create(id: 43, number: 4, name: 'มีการตรวจความพร้อมของพนักงานขับรถก่อนปฏิบัติงานทุกครั้ง (เช่น ระดับแอลกอฮอล์และสารเสพติด)', criteria_group_id: 8,weight: 0)
Criterium.create(id: 44, number: 5, name: 'กำหนดจุดพักรถและที่พักสำหรับพนักงานขับรถระหว่างเส้นทางขนส่งอย่างเหมาะสม', criteria_group_id: 8,weight: 0)

Criterium.create(id: 45, number: 1, name: 'เดินรถตามเส้นทางตามที่กำหนดในใบอนุญาตประกอบการเดินรถ', criteria_group_id: 9,weight: 0)
Criterium.create(id: 46, number: 2, name: 'จำนวนรถที่มีอยู่จริง ตรงตามเงื่อนไขจำนวนรถขั้นต่ำ-ขั้นสูง', criteria_group_id: 9,weight: 0)
Criterium.create(id: 47, number: 3, name: 'จำนวนเที่ยวเดินรถจริงเฉลี่ยต่อวัน ไม่น้อยกว่าจำนวนเที่ยวการเดินรถขั้นต่ำ', criteria_group_id: 9,weight: 0)
Criterium.create(id: 48, number: 4, name: 'เวลาเดินรถเที่ยวแรก-เที่ยวสุดท้ายตรงตามที่กำหนดในใบอนุญาตประกอบการขนส่ง', criteria_group_id: 9,weight: 0)
Criterium.create(id: 49, number: 5, name: 'เก็บค่าโดยสารตามอัตราที่กำหนด', criteria_group_id: 9,weight: 0)
Criterium.create(id: 50, number: 6, name: 'มีการชำระภาษีรถทุกคัน', criteria_group_id: 9,weight: 0)
Criterium.create(id: 51, number: 7, name: 'มีการติดตั้ง GPS และเชื่อมต่อข้อมูลกับกรมการขนส่งทางบกทุกคัน', criteria_group_id: 9,weight: 0)
Criterium.create(id: 52, number: 8, name: 'สถานที่เก็บ ซ่อม และบำรุงรักษารถโดยสาร มีความเหมาะสมและเพียงพอ', criteria_group_id: 9,weight: 0)
Criterium.create(id: 53, number: 9, name: 'มีการตรวจความพร้อมของพนักงานขับรถก่อนปฏิบัติงานทุกครั้ง (เช่น ระดับแอลกอฮอล์และสารเสพติด)', criteria_group_id: 9,weight: 0)
Criterium.create(id: 54, number: 10, name: 'กำหนดจุดพักรถและที่พักสำหรับพนักงานขับรถระหว่างเส้นทางขนส่งอย่างเหมาะสม', criteria_group_id: 9,weight: 0)

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
Evidence.create(id: 1, name: 'นโยบายบริษัท')
Evidence.create(id: 2, name: 'วัตถุประสงค์การดำเนินการ')
Evidence.create(id: 3, name: 'โครงสร้างการบริหารองค์กร')
Evidence.create(id: 4, name: 'ผังกระบวนการทางธุรกิจ')
Evidence.create(id: 5, name: 'นโยบายเฉพาะด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์')
Evidence.create(id: 6, name: 'เอกสารกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน (KPI)')
Evidence.create(id: 7, name: 'เอกสารแสดงช่องทางการรับข้อเสนอแนะและข้อร้องเรียน')
Evidence.create(id: 8, name: 'ใบรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ')
Evidence.create(id: 9, name: 'คู่มือการปฏิบัติงาน อธิบายขั้นตอนกระบวนทำงาน')
Evidence.create(id: 10, name: 'สมุดพนักงาน')
Evidence.create(id: 11, name: 'สมุดประจำรถ')
Evidence.create(id: 12, name: 'บันทึกการปฏิบัติงานขนส่ง')
Evidence.create(id: 13, name: 'แผนการดำเนินงาน')
Evidence.create(id: 14, name: 'แผนการจัดตารางการเดินรถและการเข้างานของพนักงาน')
Evidence.create(id: 15, name: 'รายงานสรุปผลการปฏิบัติงาน')
Evidence.create(id: 16, name: 'รายงานสำหรับผู้บริหารที่แสดงประสิทธิผลการดำเนินงาน')
Evidence.create(id: 17, name: 'บันทึกข้อมูลปริมาณการใช้เชื้อเพลิงโดยรวมทั้งหมู่ยานพาหนะและรายคัน')
Evidence.create(id: 18, name: 'ใบแสดงการตรวจสอบอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย')
Evidence.create(id: 19, name: 'ระเบียบการบำรุงรักษายานพาหนะและประวัติการซ่อมบำรุงของรถรายคัน')
Evidence.create(id: 20, name: 'หลักฐานการทำประกันภัยภาคสมัครใจหรือประกันภัยส่วนบุคคลเพิ่มเติม')
Evidence.create(id: 21, name: 'ใบแสดงการตรวจสอบความสะอาดและความพร้อมของรถโดยสารก่อนออกเดินทาง')
Evidence.create(id: 22, name: 'ภาพถ่ายแสดงอุปกรณ์ส่วนควบต่าง ๆ ที่อยู่นอกเหนือข้อบังคับตามกฎหมาย')
Evidence.create(id: 23, name: 'ระเบียบการสมัครงาน')
Evidence.create(id: 24, name: 'เอกสารบันทึกประวัติของพนักงาน')
Evidence.create(id: 25, name: 'ระเบียบการรับสมัครและรายงานการตรวจสอบประวัติของพนักงานขับรถ')
Evidence.create(id: 26, name: 'เอกสารแสดงกฎระเบียบและความรับผิดชอบของพนักงาน')
Evidence.create(id: 27, name: 'ใบพรรณนาลักษณะงาน (JD) และแผนการสื่อสารให้พนักงานรับทราบ')
Evidence.create(id: 28, name: 'แผนการฝึกอบรมทักษะและประสบการณ์พนักงาน')
Evidence.create(id: 29, name: 'เอกสารระบุชั่วโมงทำงานและวันหยุดของพนักงานในแต่ละตำแหน่งหน้าที่')
Evidence.create(id: 30, name: 'เอกสารแสดงระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมายขององค์กร')
Evidence.create(id: 31, name: 'หลักฐานแสดงการตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่')
Evidence.create(id: 32, name: 'แผนการสร้างเสริมสุขภาพของพนักงาน')
Evidence.create(id: 33, name: 'คู่มือการจัดการเหตุฉุกเฉิน')
Evidence.create(id: 34, name: 'รายงานบันทึกข้อมูลการเกิดอุบัติเหตุ')
Evidence.create(id: 35, name: 'เอกสารหรือคู่มือการอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัย')
Evidence.create(id: 36, name: 'เอกสารหรือคู่มือการอบรมวิธีการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ')
Evidence.create(id: 37, name: 'แผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน')
Evidence.create(id: 38, name: 'เอกสารแสดงมาตรการเยียวยาผู้เสียหายและแนวทางป้องกันการเกิดอุบัติเหตุซ้ำซ้อน')

#
#---- CriteriumEvidence
#
#
CriteriumEvidence.create(id: 1, criterium_id:1, evidence_id:1)
CriteriumEvidence.create(id: 2, criterium_id:1, evidence_id:2)
CriteriumEvidence.create(id: 3, criterium_id:1, evidence_id:3)
CriteriumEvidence.create(id: 4, criterium_id:1, evidence_id:4)
CriteriumEvidence.create(id: 5, criterium_id:2, evidence_id:5)
CriteriumEvidence.create(id: 6, criterium_id:3, evidence_id:6)
CriteriumEvidence.create(id: 7, criterium_id:4, evidence_id:7)
CriteriumEvidence.create(id: 8, criterium_id:5, evidence_id:8)
CriteriumEvidence.create(id: 9, criterium_id:6, evidence_id:9)
CriteriumEvidence.create(id: 10, criterium_id:7, evidence_id:10)
CriteriumEvidence.create(id: 11, criterium_id:7, evidence_id:11)
CriteriumEvidence.create(id: 12, criterium_id:7, evidence_id:12)
CriteriumEvidence.create(id: 13, criterium_id:8, evidence_id:13)
CriteriumEvidence.create(id: 14, criterium_id:8, evidence_id:14)
CriteriumEvidence.create(id: 15, criterium_id:9, evidence_id:15)
CriteriumEvidence.create(id: 16, criterium_id:9, evidence_id:16)
CriteriumEvidence.create(id: 17, criterium_id:10, evidence_id:17)
CriteriumEvidence.create(id: 18, criterium_id:11, evidence_id:18)
CriteriumEvidence.create(id: 19, criterium_id:12, evidence_id:19)
CriteriumEvidence.create(id: 20, criterium_id:13, evidence_id:20)
CriteriumEvidence.create(id: 21, criterium_id:14, evidence_id:21)
CriteriumEvidence.create(id: 22, criterium_id:15, evidence_id:22)
CriteriumEvidence.create(id: 23, criterium_id:16, evidence_id:23)
CriteriumEvidence.create(id: 24, criterium_id:16, evidence_id:24)
CriteriumEvidence.create(id: 25, criterium_id:17, evidence_id:25)
CriteriumEvidence.create(id: 26, criterium_id:18, evidence_id:26)
CriteriumEvidence.create(id: 27, criterium_id:18, evidence_id:27)
CriteriumEvidence.create(id: 28, criterium_id:19, evidence_id:28)
CriteriumEvidence.create(id: 29, criterium_id:20, evidence_id:29)
CriteriumEvidence.create(id: 30, criterium_id:21, evidence_id:30)
CriteriumEvidence.create(id: 31, criterium_id:22, evidence_id:31)
CriteriumEvidence.create(id: 32, criterium_id:22, evidence_id:32)
CriteriumEvidence.create(id: 33, criterium_id:23, evidence_id:33)
CriteriumEvidence.create(id: 34, criterium_id:24, evidence_id:34)
CriteriumEvidence.create(id: 35, criterium_id:25, evidence_id:35)
CriteriumEvidence.create(id: 36, criterium_id:26, evidence_id:36)
CriteriumEvidence.create(id: 37, criterium_id:27, evidence_id:37)
CriteriumEvidence.create(id: 38, criterium_id:28, evidence_id:38)

#
# -- add attachment to the first application
#
a1 = Application.first
folder = 'example/identity/'

filename = 'หนังสือยืนยันการเข้าร่วม Q-Bus.pdf'
att = Attachment.create(application: a1, attachment_type: :signup)
att.data.attach io: File.open(folder+filename),filename: filename

filename = 'ใบอนุญาตประกอบการขนส่ง.jpg'
att = Attachment.create(application: a1, attachment_type: :license)
att.data.attach io: File.open(folder+filename),filename: filename

filename = 'สัญญาประกอบการรถขนส่งสาธารณะ.pdf'
att = Attachment.create(application: a1, attachment_type: :contract)
att.data.attach io: File.open(folder+filename),filename: filename

# -- add evidence
folder = 'example/evidence/'
Dir.glob(folder+'*').each do |fn|
  filename = File.basename(fn)
  a = filename[0...(filename.index('.'))].to_i
  puts "adding [#{fn}] to the first application"
  att = Attachment.create(application: a1, attachment_type: :criterium_evidence, evidence_id: a)
  att.data.attach io: File.open(fn),filename: filename
end
