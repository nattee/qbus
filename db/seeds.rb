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
User.create(id: 2, name: 'สมปอง (เจ้าหน้าที่)', email: 'test2@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, verifier: 0, surveyor: 1, committee: 1})
User.create(id: 3, name: 'คุณสมชาย (ผู้ประกอบการ)', email: 'test3@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, licensee: 1})

Licensee.create(id: 1, name: 'ผู้ประกอบการหนึ่ง', license_no: 'หมายเลขผู้ประกอบการหนึ่ง', car_count: '100', contact: 'เจ้านายผู้ประกบอการ', contact_tel: '0123456789')
Licensee.create(id: 2, name: 'ผู้ประกอบการสอง', license_no: 'หมายเลขผู้ประกอบการสอง', car_count: '10', contact: 'ลูกน้องผู้ประกบอการ', contact_tel: '0987654321')

Route.create(id: 1, name: 'เส้นทางที่หนึ่ง', start: 'ป้ายแรก', destination: 'ป้ายสุดท้าย', car_count: 10, route_type: 'รถเมล์', route_no: 'no1')
Route.create(id: 2, name: 'เส้นทางที่สอง', start: 'ป้ายแรกแรก', destination: 'ป้ายท้ายท้าย', car_count: 10, route_type: 'รถสองแถว', route_no: 'no2')

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

#
# ------------------ Criteria
#
Criterium.create(id: 1, number: 1, name: 'มีโครงสร้างการบริหารงานที่ชัดเจน', criteria_group_id: 1,weight: 20)
Criterium.create(id: 2, number: 2, name: 'มีการกำหนดนโยบายและวิสัยทัศน์ ด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์อย่างชัดเจน', criteria_group_id: 1,weight: 20)
Criterium.create(id: 3, number: 3, name: 'มีการกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน', criteria_group_id: 1,weight: 20)
Criterium.create(id: 4, number: 4, name: 'มีช่องทางรับข้อเสนอแนะและข้อร้องเรียนจากลูกค้า และการประเมินระดับความพึงพอใจของลูกค้า', criteria_group_id: 1,weight: 20)
Criterium.create(id: 5, number: 5, name: 'ได้การรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ เช่น ISO 9001 ISO 14001 หรือรางวัลต่าง ๆ', criteria_group_id: 1,weight: 20)

Criterium.create(id: 6, number: 1, name: 'มีการกำหนดขั้นตอนการปฏิบัติงานและคู่มือการปฏิบัติงาน', criteria_group_id: 2,weight: 20)
Criterium.create(id: 7, number: 2, name: 'มีการลงบันทึกสมุดพนักงานขับรถ/สมุดประจำรถ หรือบันทึกการปฏิบัติงานขนส่ง เพื่อเป็นหลักฐานการใช้รถขนส่งทุกครั้ง', criteria_group_id: 2,weight: 20)
Criterium.create(id: 8, number: 3, name: 'มีแผนการจัดตารางการเดินรถและการเข้างานของพนักงานที่ชัดเจน', criteria_group_id: 2,weight: 20)
Criterium.create(id: 9, number: 4, name: 'มีการบันทึกผลการปฏิบัติงานที่แสดงประสิทธิผลการดำเนินงานอย่างเหมาะสม', criteria_group_id: 2,weight: 20)
Criterium.create(id: 10, number: 5, name: 'มีการบันทึกข้อมูลปริมาณการใช้เชื้อเพลิงโดยรวมทั้งหมู่ยานพาหนะและรายคัน', criteria_group_id: 2,weight: 20)

Criterium.create(id: 11, number: 1, name: 'มีความพร้อมของอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย', criteria_group_id: 3,weight: 20)
Criterium.create(id: 12, number: 2, name: 'มีการจัดทำประวัติการใช้รถและประวัติการซ่อมบำรุงของรถรายคัน', criteria_group_id: 3,weight: 20)
Criterium.create(id: 13, number: 3, name: 'มีประกันภัยภาคสมัครใจหรือประกันภัยส่วนบุคคลเพิ่มเติม', criteria_group_id: 3,weight: 20)
Criterium.create(id: 14, number: 4, name: 'มีการดูแลความสะอาดของรถโดยสารอย่างสม่ำเสมอ', criteria_group_id: 3,weight: 20)
Criterium.create(id: 15, number: 5, name: 'อุปกรณ์ส่วนควบที่อยู่นอกเหนือข้อบังคับตามกฎหมายต่าง ๆ', criteria_group_id: 3,weight: 20)

Criterium.create(id: 16, number: 1, name: 'มีการกำหนดขั้นตอนการรับสมัครพนักงาน บันทึก และเก็บรักษาประวัติพนักงานอย่างเหมาะสม', criteria_group_id: 4,weight: 20)
Criterium.create(id: 17, number: 2, name: 'มีระเบียบการรับสมัครและการตรวจสอบประวัติพนักงานขับรถ', criteria_group_id: 4,weight: 20)
Criterium.create(id: 18, number: 3, name: 'มีการแสดงกฎระเบียบและความรับผิดชอบของพนักงาน รวมถึงบทลงโทษ และประกาศให้พนักงานรับทราบอย่างทั่วถึง', criteria_group_id: 4,weight: 20)
Criterium.create(id: 19, number: 4, name: 'มีการวางแผนกำหนดชั่วโมงทำงาน วันหยุด และดำเนินการอย่างเหมาะสม', criteria_group_id: 4,weight: 20)
Criterium.create(id: 20, number: 5, name: 'มีแผนการฝึกอบรมทักษะและประสบการณ์พนักงาน และดำเนินการอย่างเหมาะสม', criteria_group_id: 4,weight: 20)
Criterium.create(id: 21, number: 6, name: 'มีระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมายขององค์กร', criteria_group_id: 4,weight: 20)
Criterium.create(id: 22, number: 7, name: 'มีการสร้างเสริมสุขภาพของพนักงาน ตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่ มีการบันทึกและเก็บรักษาผลอย่างเป็นระบบ', criteria_group_id: 4,weight: 20)

Criterium.create(id: 23, number: 1, name: 'มีคู่มือการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ ที่จำเป็นอย่างชัดเจน', criteria_group_id: 5,weight: 20)
Criterium.create(id: 24, number: 2, name: 'มีการบันทึกข้อมูลการเกิดอุบัติเหตุต่าง ๆ อย่างต่อเนื่อง', criteria_group_id: 5,weight: 20)
Criterium.create(id: 25, number: 3, name: 'มีการวางแผนอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัย เป็นประจำ', criteria_group_id: 5,weight: 20)
Criterium.create(id: 26, number: 4, name: 'มีการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ', criteria_group_id: 5,weight: 20)
Criterium.create(id: 27, number: 5, name: 'มีแผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน', criteria_group_id: 5,weight: 20)
Criterium.create(id: 28, number: 6, name: 'มีมาตรการเยียวยาผู้เสียหายและแนวทางป้องกันการเกิดอุบัติเหตุซ้ำซ้อน', criteria_group_id: 5,weight: 20)

Criterium.create(id: 29, number: 1, name: 'มีการควบคุมความเร็วการขับขี่รถอย่างเหมาะสม เพื่อความปลอดภัย โดยตรวจสอบจากข้อมูลการใช้งานระบบบอกตำแหน่งบนโลก (GPS) ของกรมการขนส่งทางบก', criteria_group_id: 6,weight: 20)
Criterium.create(id: 30, number: 2, name: 'มีอัตราการเกิดอุบัติเหตุต่ำ เช่น น้อยกว่า 1 ครั้งต่อระยะทาง 300,000 - 600,000 กิโลเมตร ต่อปี (ขึ้นอยู่กับระยะทางวิ่งตามเส้นทางที่กำหนดในใบอนุญาตฯ)', criteria_group_id: 6,weight: 20)
Criterium.create(id: 31, number: 3, name: 'ไม่เคยเกิดอุบัติเหตุรุนแรง ในช่วงเวลา 1 ปี', criteria_group_id: 6,weight: 20)

Criterium.create(id: 32, number: 1, name: 'เดินรถตามเส้นทางตามที่กำหนดในใบอนุญาตประกอบการเดินรถ', criteria_group_id: 7,weight: 20)
Criterium.create(id: 33, number: 2, name: 'จำนวนรถที่มีอยู่จริง ตรงตามเงื่อนไขจำนวนรถขั้นต่ำ-ขั้นสูง', criteria_group_id: 7,weight: 20)
Criterium.create(id: 34, number: 3, name: 'จำนวนเที่ยวเดินรถจริงเฉลี่ยต่อวัน ไม่น้อยกว่าจำนวนเที่ยวการเดินรถขั้นต่ำ', criteria_group_id: 7,weight: 20)
Criterium.create(id: 35, number: 4, name: 'เก็บค่าโดยสารตามอัตราที่กำหนด', criteria_group_id: 7,weight: 20)
Criterium.create(id: 36, number: 5, name: 'เวลาเดินรถตรงตามที่กำหนดในใบอนุญาตประกอบการขนส่ง', criteria_group_id: 7,weight: 20)

Criterium.create(id: 37, number: 1, name: 'มีแผนการตรวจสภาพและบำรุงรักษาและดำเนินการอย่างเหมาะสม', criteria_group_id: 8,weight: 20)
Criterium.create(id: 38, number: 2, name: 'มีการชำระภาษีรถทุกคัน', criteria_group_id: 8,weight: 20)
Criterium.create(id: 39, number: 3, name: 'มีการติดตั้ง GPS และเชื่อมต่อข้อมูลกับกรมการขนส่งทางบกทุกคัน', criteria_group_id: 8,weight: 20)
Criterium.create(id: 40, number: 4, name: 'มีการตรวจความพร้อมของพนักงานขับรถก่อนปฏิบัติงานทุกครั้ง (เช่น ระดับแอลกอฮอล์และสารเสพติด)', criteria_group_id: 8,weight: 20)
Criterium.create(id: 41, number: 5, name: 'กำหนดจุดพักรถและที่พักสำหรับพนักงานขับรถระหว่างเส้นทางขนส่งอย่างเหมาะสม', criteria_group_id: 8,weight: 20)


Evaluation.create(id: 1, application: Application.first(), evaluator: 'ผู้ตรวรการ', evaluation_date: 1.month.ago, result: true, description: 'ผ่าน', criterium: Criterium.first())
Evaluation.create(id: 2, application: Application.last(), evaluator: 'ผู้คุม', evaluation_date: 1.year.ago, result: false, description: 'ไม่ผ่าน', criterium: Criterium.last())

#
#--- evidence ----------
#
Evidence.create(id: 1, name: 'นโยบายองค์กรและการประกอบการ')
Evidence.create(id: 2, name: 'โครงสร้างการบริหารองค์กร')
Evidence.create(id: 3, name: 'ผังกระบวนการทางธุรกิจ')
Evidence.create(id: 4, name: 'นโยบายเฉพาะด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์')
Evidence.create(id: 5, name: 'เอกสารกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน (KPI)')
Evidence.create(id: 6, name: 'เอกสารแสดงช่องทางการรับข้อเสนอแนะและข้อร้องเรียน')
Evidence.create(id: 7, name: 'ใบรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ')
Evidence.create(id: 8, name: 'คู่มือการปฏิบัติงาน อธิบายขั้นตอนกระบวนทำงาน')
Evidence.create(id: 9, name: 'สมุดพนักงาน')
Evidence.create(id: 10, name: 'สมุดประจำรถ')
Evidence.create(id: 11, name: 'บันทึกการปฏิบัติงานขนส่ง')
Evidence.create(id: 12, name: 'แผนการดำเนินงาน')
Evidence.create(id: 13, name: 'แผนการจัดตารางการเดินรถและการเข้างานของพนักงาน')
Evidence.create(id: 14, name: 'รายงานสรุปผลการปฏิบัติงาน')
Evidence.create(id: 15, name: 'รายงานสำหรับผู้บริหารที่แสดงประสิทธิผลการดำเนินงาน')
Evidence.create(id: 16, name: 'บันทึกข้อมูลปริมาณการใช้เชื้อเพลิงโดยรวมทั้งหมู่ยานพาหนะและรายคัน')
Evidence.create(id: 17, name: 'ใบแสดงการตรวจสอบอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย')
Evidence.create(id: 18, name: 'ระเบียบการบำรุงรักษายานพาหนะและประวัติการซ่อมบำรุงของรถรายคัน')
Evidence.create(id: 19, name: 'หลักฐานการทำประกันภัยภาคสมัครใจหรือประกันภัยส่วนบุคคลเพิ่มเติม')
Evidence.create(id: 20, name: 'ใบแสดงการตรวจสอบความสะอาดและความพร้อมของรถโดยสารก่อนออกเดินทาง')
Evidence.create(id: 21, name: 'ภาพถ่ายแสดงอุปกรณ์ส่วนควบต่าง ๆ ที่อยู่นอกเหนือข้อบังคับตามกฎหมาย')
Evidence.create(id: 22, name: 'ระเบียบการสมัครงาน')
Evidence.create(id: 23, name: 'เอกสารบันทึกประวัติของพนักงาน')
Evidence.create(id: 24, name: 'ระเบียบการรับสมัครและรายงานการตรวจสอบประวัติของพนักงานขับรถ')
Evidence.create(id: 25, name: 'เอกสารแสดงกฎระเบียบและความรับผิดชอบของพนักงาน')
Evidence.create(id: 26, name: 'ใบพรรณนาลักษณะงาน (JD) และแผนการสื่อสารให้พนักงานรับทราบ')
Evidence.create(id: 27, name: 'แผนการฝึกอบรมทักษะและประสบการณ์พนักงาน')
Evidence.create(id: 28, name: 'เอกสารระบุชั่วโมงทำงานและวันหยุดของพนักงานในแต่ละตำแหน่งหน้าที่')
Evidence.create(id: 29, name: 'เอกสารแสดงระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมายขององค์กร')
Evidence.create(id: 30, name: 'หลักฐานแสดงการตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่')
Evidence.create(id: 31, name: 'แผนการสร้างเสริมสุขภาพของพนักงาน')
Evidence.create(id: 32, name: 'คู่มือการจัดการเหตุฉุกเฉิน')
Evidence.create(id: 33, name: 'รายงานบันทึกข้อมูลการเกิดอุบัติเหตุ')
Evidence.create(id: 34, name: 'เอกสารหรือคู่มือการอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัย')
Evidence.create(id: 35, name: 'เอกสารหรือคู่มือการอบรมวิธีการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ')
Evidence.create(id: 36, name: 'แผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน')
Evidence.create(id: 37, name: 'เอกสารแสดงมาตรการเยียวยาผู้เสียหายและแนวทางป้องกันการเกิดอุบัติเหตุซ้ำซ้อน')
Evidence.create(id: 38, name: 'ข้อมูลการกระทำผิดของรถโดยสารสาธารณะ แยกตามเส้นทางและใบอนุญาต จากฐานข้อมูลศูนย์ GPS ย้อนหลัง 3 เดือน')
Evidence.create(id: 39, name: 'ข้อมูลอุบัติเหตถของรถโดยสารสาธารณะ ทั่วประเทศ ย้อนหลัง 12 เดือน')

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
CriteriumEvidence.create(id: 10, criterium_id:7, evidence_id:10)
CriteriumEvidence.create(id: 11, criterium_id:7, evidence_id:11)
CriteriumEvidence.create(id: 12, criterium_id:8, evidence_id:12)
CriteriumEvidence.create(id: 13, criterium_id:8, evidence_id:13)
CriteriumEvidence.create(id: 14, criterium_id:9, evidence_id:14)
CriteriumEvidence.create(id: 15, criterium_id:9, evidence_id:15)
CriteriumEvidence.create(id: 16, criterium_id:10, evidence_id:16)
CriteriumEvidence.create(id: 17, criterium_id:11, evidence_id:17)
CriteriumEvidence.create(id: 18, criterium_id:12, evidence_id:18)
CriteriumEvidence.create(id: 19, criterium_id:13, evidence_id:19)
CriteriumEvidence.create(id: 20, criterium_id:14, evidence_id:20)
CriteriumEvidence.create(id: 21, criterium_id:15, evidence_id:21)
CriteriumEvidence.create(id: 22, criterium_id:16, evidence_id:22)
CriteriumEvidence.create(id: 23, criterium_id:16, evidence_id:23)
CriteriumEvidence.create(id: 24, criterium_id:17, evidence_id:24)
CriteriumEvidence.create(id: 25, criterium_id:18, evidence_id:25)
CriteriumEvidence.create(id: 26, criterium_id:18, evidence_id:26)
CriteriumEvidence.create(id: 27, criterium_id:19, evidence_id:27)
CriteriumEvidence.create(id: 28, criterium_id:20, evidence_id:28)
CriteriumEvidence.create(id: 29, criterium_id:21, evidence_id:29)
CriteriumEvidence.create(id: 30, criterium_id:22, evidence_id:30)
CriteriumEvidence.create(id: 31, criterium_id:22, evidence_id:31)
CriteriumEvidence.create(id: 32, criterium_id:23, evidence_id:32)
CriteriumEvidence.create(id: 33, criterium_id:24, evidence_id:33)
CriteriumEvidence.create(id: 34, criterium_id:25, evidence_id:34)
CriteriumEvidence.create(id: 35, criterium_id:26, evidence_id:35)
CriteriumEvidence.create(id: 36, criterium_id:27, evidence_id:36)
CriteriumEvidence.create(id: 37, criterium_id:28, evidence_id:37)
CriteriumEvidence.create(id: 38, criterium_id:29, evidence_id:38)
CriteriumEvidence.create(id: 39, criterium_id:30, evidence_id:39)


#
# -- no longer used
#
# CriteriumAttachment.create(id: 1, name: 'นโยบายการประกอบการ', description: 'นโยบายการประกอบการ', required: true, criterium_id: 1)
# CriteriumAttachment.create(id: 2, name: 'โครงสร้างบริหารองค์กร', description: 'โครงสร้างบริหารองค์กร', required: true, criterium_id: 1)
# CriteriumAttachment.create(id: 3, name: 'ใบพรรณนาลักษณะงาน (JD)', description: 'ใบพรรณนาลักษณะงาน (JD)', required: true, criterium_id: 1)
# CriteriumAttachment.create(id: 4, name: 'การสื่อสารให้พนักงานรับทราบ', description: 'การสื่อสารให้พนักงานรับทราบ', required: true, criterium_id: 1)
# CriteriumAttachment.create(id: 5, name: 'นโยบายการประกอบการ', description: 'นโยบายการประกอบการ', required: true, criterium_id: 2)
# CriteriumAttachment.create(id: 6, name: 'นโยบายเฉพาะด้าน', description: 'นโยบายเฉพาะด้าน', required: true, criterium_id: 2)
# CriteriumAttachment.create(id: 7, name: 'การสื่อสารให้พนักงานรับทราบ', description: 'การสื่อสารให้พนักงานรับทราบ', required: true, criterium_id: 2)
# CriteriumAttachment.create(id: 8, name: 'ตัวชี้วัดประสิทธิภาพ KPI', description: 'ตัวชี้วัดประสิทธิภาพ KPI', required: true, criterium_id: 3)
# CriteriumAttachment.create(id: 9, name: 'หนังสือรับรองมาตรฐานสากล', description: 'หนังสือรับรองมาตรฐานสากล', required: true, criterium_id: 4)
# CriteriumAttachment.create(id: 10, name: 'รางวัลทางธุรกิจต่าง ๆ', description: 'รางวัลทางธุรกิจต่าง ๆ', required: true, criterium_id: 4)
# CriteriumAttachment.create(id: 11, name: 'นโยบายขอบเขตความรับผิดชอบ', description: 'นโยบายขอบเขตความรับผิดชอบ', required: true, criterium_id: 5)
# CriteriumAttachment.create(id: 12, name: 'สัญญาในการว่าจ้าง', description: 'สัญญาในการว่าจ้าง', required: true, criterium_id: 5)
# CriteriumAttachment.create(id: 13, name: 'ประกันภัยสำหรับผู้โดยสาร', description: 'ประกันภัยสำหรับผู้โดยสาร', required: true, criterium_id: 5)
# CriteriumAttachment.create(id: 14, name: 'ผังกระบวนการทางธุรกิจ', description: 'ผังกระบวนการทางธุรกิจ', required: true, criterium_id: 6)
# CriteriumAttachment.create(id: 15, name: 'ผังกระบวนการทางธุรกิจ', description: 'ผังกระบวนการทางธุรกิจ', required: true, criterium_id: 6)
# CriteriumAttachment.create(id: 16, name: 'แผนการดำเนินการในระยะยาว', description: 'แผนการดำเนินการในระยะยาว', required: true, criterium_id: 6)
# CriteriumAttachment.create(id: 17, name: 'หนังสือรับรองการเป็นสมาชิก', description: 'หนังสือรับรองการเป็นสมาชิก', required: true, criterium_id: 7)
# CriteriumAttachment.create(id: 18, name: 'บัตรประจำตัวสมาชิก', description: 'บัตรประจำตัวสมาชิก', required: true, criterium_id: 7)
# CriteriumAttachment.create(id: 19, name: 'รายงานการประชุมประจำปี', description: 'รายงานการประชุมประจำปี', required: true, criterium_id: 7)
# CriteriumAttachment.create(id: 20, name: 'รายละเอียดการเข้าร่วมกิจกรรม', description: 'รายละเอียดการเข้าร่วมกิจกรรม', required: true, criterium_id: 7)
# CriteriumAttachment.create(id: 21, name: 'รายละเอียดสถานที่ประกอบการ', description: 'รายละเอียดสถานที่ประกอบการ', required: true, criterium_id: 8)
#
#
#
# CriteriumAttachment.create(id: 22, name: 'ขั้นตอนกระบวนการโดยสาร', description: 'ขั้นตอนกระบวนการโดยสาร', required: true, criterium_id: 10)
# CriteriumAttachment.create(id: 23, name: 'ผังกระบวนการปฏิบัติงาน', description: 'ผังกระบวนการปฏิบัติงาน', required: true, criterium_id: 10)
# CriteriumAttachment.create(id: 24, name: 'สมุดพนักงาน/สมุดประจำรถ', description: 'สมุดพนักงาน/สมุดประจำรถ', required: true, criterium_id: 11)
# CriteriumAttachment.create(id: 25, name: 'บันทึกการปฏิบัติงานขนส่ง', description: 'บันทึกการปฏิบัติงานขนส่ง', required: true, criterium_id: 11)
# CriteriumAttachment.create(id: 26, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 12)
# CriteriumAttachment.create(id: 27, name: 'แผนการดำเนงาน', description: 'แผนการดำเนงาน', required: true, criterium_id: 12)
# CriteriumAttachment.create(id: 28, name: 'การสรุปผลปฏิบัติงานขนส่ง', description: 'การสรุปผลปฏิบัติงานขนส่ง', required: true, criterium_id: 13)
# CriteriumAttachment.create(id: 29, name: 'รายงานสำหรับผู้บริหาร', description: 'รายงานสำหรับผู้บริหาร', required: true, criterium_id: 13)
# CriteriumAttachment.create(id: 30, name: 'ระเบียบการจัดการข้อผิดพลาด', description: 'ระเบียบการจัดการข้อผิดพลาด', required: true, criterium_id: 14)
# CriteriumAttachment.create(id: 31, name: 'รายงานข้อผิดพลาด', description: 'รายงานข้อผิดพลาด', required: true, criterium_id: 14)
# CriteriumAttachment.create(id: 32, name: 'มาตรการป้องกันข้อผิดพลาด', description: 'มาตรการป้องกันข้อผิดพลาด', required: true, criterium_id: 14)
# CriteriumAttachment.create(id: 33, name: 'รายการปวัติข้อผิดพลาด', description: 'รายการปวัติข้อผิดพลาด', required: true, criterium_id: 14)
# CriteriumAttachment.create(id: 34, name: 'รายงานสรุปการใช้เชื้อเพลิง', description: 'รายงานสรุปการใช้เชื้อเพลิง', required: true, criterium_id: 15)
# CriteriumAttachment.create(id: 35, name: 'ฐานข้อมูลผู้โดยสาร', description: 'ฐานข้อมูลผู้โดยสาร', required: true, criterium_id: 16)
# CriteriumAttachment.create(id: 36, name: 'ประวัติการใช้บริการ', description: 'ประวัติการใช้บริการ', required: true, criterium_id: 16)
# CriteriumAttachment.create(id: 37, name: 'การสำรวจความพึงพอใจของผู้โดยสาร', description: 'การสำรวจความพึงพอใจของผู้โดยสาร', required: true, criterium_id: 17)
# CriteriumAttachment.create(id: 38, name: 'รายงานการประชุม', description: 'รายงานการประชุม', required: true, criterium_id: 18)
# CriteriumAttachment.create(id: 39, name: 'เอกสารประกอบการประชุม', description: 'เอกสารประกอบการประชุม', required: true, criterium_id: 18)
# CriteriumAttachment.create(id: 40, name: 'การตอบสนองการรับข้อร้องเรียน', description: 'การตอบสนองการรับข้อร้องเรียน', required: true, criterium_id: 19)
# CriteriumAttachment.create(id: 41, name: 'การรับข้อเสนอแนะ/ข้อร้องเรียน', description: 'การรับข้อเสนอแนะ/ข้อร้องเรียน', required: true, criterium_id: 20)
#
#
#
# CriteriumAttachment.create(id: 42, name: 'ใบแสดงการตรวจสอบอุปกรณ์', description: 'ใบแสดงการตรวจสอบอุปกรณ์', required: true, criterium_id: 21)
# CriteriumAttachment.create(id: 43, name: 'ระเบียบการบำรุงรักษายานพาหนะ', description: 'ระเบียบการบำรุงรักษายานพาหนะ', required: true, criterium_id: 22)
# CriteriumAttachment.create(id: 44, name: 'ตารางการซ่อมบำรุง', description: 'ตารางการซ่อมบำรุง', required: true, criterium_id: 22)
# CriteriumAttachment.create(id: 45, name: 'หลักฐานการสมัครประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคล', description: 'หลักฐานการสมัครประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคล', required: true, criterium_id: 23)
# CriteriumAttachment.create(id: 46, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 24)
# CriteriumAttachment.create(id: 47, name: 'กฎระเบียบการทำงาน', description: 'กฎระเบียบการทำงาน', required: true, criterium_id: 24)
# CriteriumAttachment.create(id: 48, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 25)
# CriteriumAttachment.create(id: 49, name: 'ใบแสดงอุปกรณ์', description: 'ใบแสดงอุปกรณ์', required: true, criterium_id: 25)
# CriteriumAttachment.create(id: 50, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 26)
# CriteriumAttachment.create(id: 51, name: 'แนวทางการควบคุม', description: 'แนวทางการควบคุม', required: true, criterium_id: 26)
# CriteriumAttachment.create(id: 52, name: 'กฎระเบียบการทำงาน', description: 'กฎระเบียบการทำงาน', required: true, criterium_id: 26)
# CriteriumAttachment.create(id: 53, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 27)
# CriteriumAttachment.create(id: 54, name: 'แนวทางการควบคุม', description: 'แนวทางการควบคุม', required: true, criterium_id: 27)
# CriteriumAttachment.create(id: 55, name: 'กฎระเบียบการทำงาน', description: 'กฎระเบียบการทำงาน', required: true, criterium_id: 27)
#
#
#
# CriteriumAttachment.create(id: 56, name: 'ระเบียบการสมัครงาน', description: 'ระเบียบการสมัครงาน', required: true, criterium_id: 28)
# CriteriumAttachment.create(id: 57, name: 'ระเบียบการรับสมัครงาน', description: 'ระเบียบการรับสมัครงาน', required: true, criterium_id: 29)
# CriteriumAttachment.create(id: 58, name: 'วิธีปฏิบัติทดสอบความสามารถ', description: 'วิธีปฏิบัติทดสอบความสามารถ', required: true, criterium_id: 29)
# CriteriumAttachment.create(id: 59, name: 'รายงานการตรวจสอบประวัติ', description: 'รายงานการตรวจสอบประวัติ', required: true, criterium_id: 29)
# CriteriumAttachment.create(id: 60, name: 'เอกสารประวัติ', description: 'เอกสารประวัติ', required: true, criterium_id: 29)
# CriteriumAttachment.create(id: 61, name: 'กฎระเบียบการทำงานของพนักงาน', description: 'กฎระเบียบการทำงานของพนักงาน', required: true, criterium_id: 30)
# CriteriumAttachment.create(id: 62, name: 'ใบพรรณนาลักษณะงาน', description: 'ใบพรรณนาลักษณะงาน', required: true, criterium_id: 30)
# CriteriumAttachment.create(id: 63, name: 'การสื่อสารให้พนักงานรับทราบ', description: 'การสื่อสารให้พนักงานรับทราบ', required: true, criterium_id: 30)
# CriteriumAttachment.create(id: 64, name: 'เอกสารกำหนดชั่วโมงทำงานตามกฎหมาย', description: 'เอกสารกำหนดชั่วโมงทำงานตามกฎหมาย', required: true, criterium_id: 31)
# CriteriumAttachment.create(id: 65, name: 'ระเบียบการจัดฝึกอบรม', description: 'ระเบียบการจัดฝึกอบรม', required: true, criterium_id: 32)
# CriteriumAttachment.create(id: 66, name: 'แบบสำรวจความต้องการฝึกอบรม', description: 'แบบสำรวจความต้องการฝึกอบรม', required: true, criterium_id: 32)
# CriteriumAttachment.create(id: 67, name: 'ประวัติการฝึกอบรม', description: 'ประวัติการฝึกอบรม', required: true, criterium_id: 32)
# CriteriumAttachment.create(id: 68, name: 'รายละเอียดกิจกรรมเสริมการทำงาน', description: 'รายละเอียดกิจกรรมเสริมการทำงาน', required: true, criterium_id: 33)
# CriteriumAttachment.create(id: 69, name: 'หลักฐานการดำเนินการ', description: 'หลักฐานการดำเนินการ', required: true, criterium_id: 33)
# CriteriumAttachment.create(id: 70, name: 'หลักฐานการมอบรางวัล', description: 'หลักฐานการมอบรางวัล', required: true, criterium_id: 33)
# CriteriumAttachment.create(id: 71, name: 'ใบรายงานการตรวจสุขภาพ', description: 'ใบรายงานการตรวจสุขภาพ', required: true, criterium_id: 34)
#
#
#
# CriteriumAttachment.create(id: 72, name: 'คู่มือการจัดการเหตุฉุกเฉิน', description: 'คู่มือการจัดการเหตุฉุกเฉิน', required: true, criterium_id: 35)
# CriteriumAttachment.create(id: 73, name: 'คู่มือประจำรถทุกคัน', description: 'คู่มือประจำรถทุกคัน', required: true, criterium_id: 35)
# CriteriumAttachment.create(id: 74, name: 'รายงานการบันทึกอุบัติเหตุ', description: 'รายงานการบันทึกอุบัติเหตุ', required: true, criterium_id: 36)
# CriteriumAttachment.create(id: 75, name: 'รายงานการฝึกอบรม', description: 'รายงานการฝึกอบรม', required: true, criterium_id: 37)
# CriteriumAttachment.create(id: 76, name: 'ระเบียบการจัดฝึกอบรม', description: 'ระเบียบการจัดฝึกอบรม', required: true, criterium_id: 38)
# CriteriumAttachment.create(id: 77, name: 'รายงานการฝึกอบรม', description: 'รายงานการฝึกอบรม', required: true, criterium_id: 38)
# CriteriumAttachment.create(id: 78, name: 'แผนการดำเนินการ', description: 'แผนการดำเนินการ', required: true, criterium_id: 39)
#
#
# CriteriumAttachment.create(id: 79, name: 'รายละเอียดการติดตามรถ', description: 'รายละเอียดการติดตามรถ', required: true, criterium_id: 41)
# CriteriumAttachment.create(id: 80, name: 'นโยบายองค์กร', description: 'นโยบายองค์กร', required: true, criterium_id: 42)
# CriteriumAttachment.create(id: 81, name: 'แนวทางการควบคุม', description: 'แนวทางการควบคุม', required: true, criterium_id: 42)
# CriteriumAttachment.create(id: 82, name: 'กฎระเบียบการทำงาน', description: 'กฎระเบียบการทำงาน', required: true, criterium_id: 42)
# CriteriumAttachment.create(id: 83, name: 'หลักฐานบันทึกการเกิดอุบัติเหตุ', description: 'หลักฐานบันทึกการเกิดอุบัติเหตุ', required: true, criterium_id: 43)
# CriteriumAttachment.create(id: 84, name: 'หลักฐานบันทึกการเกิดอุบัติเหตุ', description: 'หลักฐานบันทึกการเกิดอุบัติเหตุ', required: true, criterium_id: 44)
#
#
#
# CriteriumAttachment.create(id: 85, name: 'คู่มือปฏิบัติงานขนส่ง', description: 'คู่มือปฏิบัติงานขนส่ง', required: true, criterium_id: 45)
# CriteriumAttachment.create(id: 86, name: 'รายการสถานที่จุดพักรถที่กำหนด', description: 'รายการสถานที่จุดพักรถที่กำหนด', required: true, criterium_id: 45)
# CriteriumAttachment.create(id: 87, name: 'ตารางการตรวจสุขภาพพนักงาน', description: 'ตารางการตรวจสุขภาพพนักงาน', required: true, criterium_id: 46)
# CriteriumAttachment.create(id: 88, name: 'รายงานผลการตรวจสุขภาพ', description: 'รายงานผลการตรวจสุขภาพ', required: true, criterium_id: 46)
# CriteriumAttachment.create(id: 89, name: 'รายละเอียดการติดตามรถ', description: 'รายละเอียดการติดตามรถ', required: true, criterium_id: 47)
# CriteriumAttachment.create(id: 90, name: 'ระเบียบการบำรุงรักษายานพาหนะ', description: 'ระเบียบการบำรุงรักษายานพาหนะ', required: true, criterium_id: 48)
# CriteriumAttachment.create(id: 91, name: 'ตารางการซ่อมบำรุง', description: 'ตารางการซ่อมบำรุง', required: true, criterium_id: 48)
