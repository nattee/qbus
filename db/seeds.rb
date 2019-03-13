# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# purge ActiveStorage data
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }

Evaluation.delete_all;
Attachment.delete_all;
Application.delete_all;
Violation.delete_all;
Datafile.delete_all;
Car.delete_all;
Route.delete_all;
Licensee.delete_all;
User.delete_all;
CriteriumAttachment.delete_all;
Criterium.delete_all;
CriteriaGroup.delete_all;

User.create(id: 1, name: 'test1@gmail.com', email: 'test1@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 1, verifier: 1, surveyor: 0})
User.create(id: 2, name: 'test2@gmail.com', email: 'test2@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: {admin: 0, verifier: 0, surveyor: 1})

Licensee.create(id: 1, name: 'ผู้ประกอบการหนึ่ง', license_no: 'หมายเลขผู้ประกอบการหนึ่ง', license_expire: 5.year.from_now, car_count: '100', contact: 'เจ้านายผู้ประกบอการ', contact_tel: '0123456789')
Licensee.create(id: 2, name: 'ผู้ประกอบการสอง', license_no: 'หมายเลขผู้ประกอบการสอง', license_expire: 5.year.from_now, car_count: '10', contact: 'ลูกน้องผู้ประกบอการ', contact_tel: '0987654321')

Route.create(id: 1, name: 'เส้นทางที่หนึ่ง', start: 'ป้ายแรก', destination: 'ป้ายสุดท้าย', car_count: 10, route_type: 'รถเมล์')
Route.create(id: 2, name: 'เส้นทางที่สอง', start: 'ป้ายแรกแรก', destination: 'ป้ายท้ายท้าย', car_count: 10, route_type: 'รถสองแถว')

Car.create(id: 1, plate: 'เลขทะเบียนรถหนึ่ง', chassis: 'เลขตัวรถหนึ่ง', licensee: Licensee.first(), route: Route.first())
Car.create(id: 2, plate: 'เลขทะเบียนรถสอง', chassis: 'เลขตัวรถสอง', licensee: Licensee.last(), route: Route.last())

Datafile.create(id: 1, name: 'ไฟล์ข้อมูลหนึ่ง', month_year: 1.year.ago, user: User.first() )
Datafile.create(id: 2, name: 'ไฟล์ข้อมูลสอง', month_year: 1.month.ago, user: User.last() )

Violation.create(id: 1, car: Car.first(), count: 10, month_year: Time.zone.now, datafile: Datafile.first())
Violation.create(id: 2, car: Car.last(), count: 20, month_year: Time.zone.now, datafile: Datafile.last())

Application.create(id: 1, number: 'หนึ่ง', user: User.first(), state: 0, licensee: Licensee.first(), route: Route.first(), appointment_date: 5.day.from_now, appointment_remark: 'กำหนดการนัดหมาย', appointment_user: User.last(), award: 'ถ้วยรางวัล', award_remark: 'พร้อมเงินโบนัส', contact: 'ผู้มารับรางวัล', contact_tel: '0192837465', category: 0, car_count: 10, trip_count: 1000)
Application.create(id: 2, number: 'สอง', user: User.last(), state: 0, licensee: Licensee.last(), route: Route.last(), appointment_date: 3.day.from_now, appointment_remark: 'นัดแล้วนะ', appointment_user: User.first(), award: 'รางวัลชมเชย', award_remark: 'พร้อมหนี้สิน', contact: 'ตัวแทน', contact_tel: '0594875632', category: 0, car_count: 4, trip_count: 100)

CriteriaGroup.create(id: 1, name: 'ข้อกำหนดด้านองค์กรและการบริหารจัดการ',group_weight: 15)
CriteriaGroup.create(id: 2, name: 'ข้อกำหนดด้านปฏิบัติงาน',group_weight: 15)
CriteriaGroup.create(id: 3, name: 'ข้อกำหนดด้านยานหาพนะ',group_weight: 20)
CriteriaGroup.create(id: 4, name: 'ข้อกำหนดด้านพนักงาน',group_weight: 20)
CriteriaGroup.create(id: 5, name: 'ข้อกำหนดด้านความปลอดภัย',group_weight: 30)

Criterium.create(id: 1, number: 1, name: 'มีโครงสร้างการบริหารงานที่ชัดเจน', criteria_group_id: 1,weight: 20)
Criterium.create(id: 2, number: 2, name: 'มีการกำหนดนโยบายและวิสัยทัศน์ ด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์ อย่างชัดเจน', criteria_group_id: 1,weight: 20)
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
Criterium.create(id: 13, number: 3, name: 'มีประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคลเพิ่มเติม​', criteria_group_id: 3,weight: 20)
Criterium.create(id: 14, number: 4, name: 'มีการดูแลความสะอาดของรถโดยสารอย่างสม่ำเสมอ', criteria_group_id: 3,weight: 20)
Criterium.create(id: 15, number: 5, name: 'อุปกรณ์ส่วนควบที่อยู่นอกเหนือข้อบังคับตามกฎหมายต่าง ๆ​', criteria_group_id: 3,weight: 20)

Criterium.create(id: 16, number: 1, name: 'มีการกำหนดขั้นตอนการรับสมัครพนักงาน บันทึก และเก็บรักษาประวัติพนักงานอย่างเหมาะสม', criteria_group_id: 4,weight: 10)
Criterium.create(id: 17, number: 2, name: 'มีระเบียบการรับสมัครพนักงานขับรถ', criteria_group_id: 4,weight: 10)
Criterium.create(id: 18, number: 3, name: 'มีการแสดงกฎระเบียบและความรับผิดชอบของพนักงาน รวมถึงบทลงโทษ และประกาศให้พนักงานรับทราบอย่างทั่วถึง', criteria_group_id: 4,weight: 20)
Criterium.create(id: 19, number: 4, name: 'มีการวางแผนกำหนดชั่วโมงทำงาน วันหยุด และดำเนินการอย่างเหมาะสม', criteria_group_id: 4,weight: 20)
Criterium.create(id: 20, number: 5, name: 'มีแผนการฝึกอบรมทักษะและประสบการณ์พนักงาน และดำเนินการอย่างเหมาะสม', criteria_group_id: 4,weight: 20)
Criterium.create(id: 21, number: 6, name: 'มีระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมาย', criteria_group_id: 4,weight: 20)
Criterium.create(id: 22, number: 7, name: 'มีการสร้างเสริมสุขภาพของพนักงาน ตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่ มีการบันทึกและเก็บรักษาผลอย่างเป็นระบบ', criteria_group_id: 4,weight: 20)

Criterium.create(id: 23, number: 1, name: 'มีคู่มือการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ ที่จำเป็นอย่างชัดเจน', criteria_group_id: 5,weight: 20)
Criterium.create(id: 24, number: 2, name: 'มีการบันทึกข้อมูลการเกิดอุบัติเหตุต่าง ๆ อย่างต่อเนื่อง', criteria_group_id: 5,weight: 20)
Criterium.create(id: 25, number: 3, name: 'มีการวางแผนอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัย  เป็นประจำ', criteria_group_id: 5,weight: 20)
Criterium.create(id: 26, number: 4, name: 'มีการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ', criteria_group_id: 5,weight: 20)
Criterium.create(id: 27, number: 5, name: 'มีแผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน', criteria_group_id: 5,weight: 20)

CriteriumAttachment.create(id: 1, name: 'มีโครงสร้างการบริหารงานที่ชัดเจน', description: 'มีโครงสร้างการบริหารงานที่ชัดเจน', required: true, criterium_id: 1)
CriteriumAttachment.create(id: 2, name: 'มีการกำหนดนโยบายและวิสัยทัศน์ ด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์ อย่างชัดเจน', description: 'มีการกำหนดนโยบายและวิสัยทัศน์ ด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์ อย่างชัดเจน', required: true, criterium_id: 2)
CriteriumAttachment.create(id: 3, name: 'มีการกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน', description: 'มีการกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน', required: true, criterium_id: 3)
CriteriumAttachment.create(id: 4, name: 'มีช่องทางรับข้อเสนอแนะและข้อร้องเรียนจากลูกค้า และการประเมินระดับความพึงพอใจของลูกค้า', description: 'มีช่องทางรับข้อเสนอแนะและข้อร้องเรียนจากลูกค้า และการประเมินระดับความพึงพอใจของลูกค้า', required: true, criterium_id: 4)
CriteriumAttachment.create(id: 5, name: 'ได้การรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ เช่น ISO 9001 ISO 14001 หรือรางวัลต่าง ๆ', description: 'ได้การรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ เช่น ISO 9001 ISO 14001 หรือรางวัลต่าง ๆ', required: true, criterium_id: 5)

CriteriumAttachment.create(id: 6, name: 'มีการกำหนดขั้นตอนการปฏิบัติงานและคู่มือการปฏิบัติงาน', description: 'มีการกำหนดขั้นตอนการปฏิบัติงานและคู่มือการปฏิบัติงาน', required: true, criterium_id: 6)
CriteriumAttachment.create(id: 7, name: 'มีการลงบันทึกสมุดพนักงานขับรถ/สมุดประจำรถ หรือบันทึกการปฏิบัติงานขนส่ง เพื่อเป็นหลักฐานการใช้รถขนส่งทุกครั้ง', description: 'มีการลงบันทึกสมุดพนักงานขับรถ/สมุดประจำรถ หรือบันทึกการปฏิบัติงานขนส่ง เพื่อเป็นหลักฐานการใช้รถขนส่งทุกครั้ง', required: true, criterium_id: 7)
CriteriumAttachment.create(id: 8, name: 'มีแผนการจัดตารางการเดินรถและการเข้างานของพนักงานที่ชัดเจน', description: 'มีแผนการจัดตารางการเดินรถและการเข้างานของพนักงานที่ชัดเจน', required: true, criterium_id: 8)
CriteriumAttachment.create(id: 9, name: 'มีการบันทึกผลการปฏิบัติงานที่แสดงประสิทธิผลการดำเนินงานอย่างเหมาะสม', description: 'มีการบันทึกผลการปฏิบัติงานที่แสดงประสิทธิผลการดำเนินงานอย่างเหมาะสม', required: true, criterium_id: 9)
CriteriumAttachment.create(id: 10, name: 'มีการบันทึกข้อมูลปริมาณการใช้เชื้อเพลิงโดยรวมทั้งหมู่ยานพาหนะและรายคัน', description: 'มีการบันทึกข้อมูลปริมาณการใช้เชื้อเพลิงโดยรวมทั้งหมู่ยานพาหนะและรายคัน', required: true, criterium_id: 10)

CriteriumAttachment.create(id: 11, name: 'มีความพร้อมของอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย', description: 'มีความพร้อมของอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย', required: true, criterium_id: 11)
CriteriumAttachment.create(id: 12, name: 'มีการจัดทำประวัติการใช้รถและประวัติการซ่อมบำรุงของรถรายคัน', description: 'มีการจัดทำประวัติการใช้รถและประวัติการซ่อมบำรุงของรถรายคัน', required: true, criterium_id: 12)
CriteriumAttachment.create(id: 13, name: 'มีประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคลเพิ่มเติม​', description: 'มีประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคลเพิ่มเติม​', required: true, criterium_id: 13)
CriteriumAttachment.create(id: 14, name: 'มีการดูแลความสะอาดของรถโดยสารอย่างสม่ำเสมอ', description: 'มีการดูแลความสะอาดของรถโดยสารอย่างสม่ำเสมอ', required: true, criterium_id: 14)
CriteriumAttachment.create(id: 15, name: 'อุปกรณ์ส่วนควบที่อยู่นอกเหนือข้อบังคับตามกฎหมายต่าง ๆ​', description: 'อุปกรณ์ส่วนควบที่อยู่นอกเหนือข้อบังคับตามกฎหมายต่าง ๆ​', required: true, criterium_id: 15)

CriteriumAttachment.create(id: 16, name: 'มีการกำหนดขั้นตอนการรับสมัครพนักงาน บันทึก และเก็บรักษาประวัติพนักงานอย่างเหมาะสม', description: 'มีการกำหนดขั้นตอนการรับสมัครพนักงาน บันทึก และเก็บรักษาประวัติพนักงานอย่างเหมาะสม', required: true, criterium_id: 16)
CriteriumAttachment.create(id: 17, name: 'มีระเบียบการรับสมัครพนักงานขับรถ', description: 'มีระเบียบการรับสมัครพนักงานขับรถ', required: true, criterium_id: 17)
CriteriumAttachment.create(id: 18, name: 'มีการแสดงกฎระเบียบและความรับผิดชอบของพนักงาน รวมถึงบทลงโทษ และประกาศให้พนักงานรับทราบอย่างทั่วถึง', description: 'มีการแสดงกฎระเบียบและความรับผิดชอบของพนักงาน รวมถึงบทลงโทษ และประกาศให้พนักงานรับทราบอย่างทั่วถึง', required: true, criterium_id: 18)
CriteriumAttachment.create(id: 19, name: 'มีการวางแผนกำหนดชั่วโมงทำงาน วันหยุด และดำเนินการอย่างเหมาะสม', description: 'มีการวางแผนกำหนดชั่วโมงทำงาน วันหยุด และดำเนินการอย่างเหมาะสม', required: true, criterium_id: 19)
CriteriumAttachment.create(id: 20, name: 'มีแผนการฝึกอบรมทักษะและประสบการณ์พนักงาน และดำเนินการอย่างเหมาะสม', description: 'มีแผนการฝึกอบรมทักษะและประสบการณ์พนักงาน และดำเนินการอย่างเหมาะสม', required: true, criterium_id: 20)
CriteriumAttachment.create(id: 21, name: 'มีระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมาย', description: 'มีระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมาย', required: true, criterium_id: 21)
CriteriumAttachment.create(id: 22, name: 'มีการสร้างเสริมสุขภาพของพนักงาน ตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่ มีการบันทึกและเก็บรักษาผลอย่างเป็นระบบ', description: 'มีการสร้างเสริมสุขภาพของพนักงาน ตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่ มีการบันทึกและเก็บรักษาผลอย่างเป็นระบบ', required: true, criterium_id: 22)

CriteriumAttachment.create(id: 23, name: 'มีคู่มือการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ ที่จำเป็นอย่างชัดเจน', description: 'มีคู่มือการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ ที่จำเป็นอย่างชัดเจน', required: true, criterium_id: 23)
CriteriumAttachment.create(id: 24, name: 'มีการบันทึกข้อมูลการเกิดอุบัติเหตุต่าง ๆ อย่างต่อเนื่อง', description: 'มีการบันทึกข้อมูลการเกิดอุบัติเหตุต่าง ๆ อย่างต่อเนื่อง', required: true, criterium_id: 24)
CriteriumAttachment.create(id: 25, name: 'มีการวางแผนอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัย  เป็นประจำ', description: 'มีการวางแผนอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัย  เป็นประจำ', required: true, criterium_id: 25)
CriteriumAttachment.create(id: 26, name: 'มีการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ', description: 'มีการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ', required: true, criterium_id: 26)
CriteriumAttachment.create(id: 27, name: 'มีแผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน', description: 'มีแผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน', required: true, criterium_id: 27)

Evaluation.create(id: 1, application: Application.first(), evaluator: 'ผู้ตรวรการ', evaluation_date: 1.month.ago, result: true, description: 'ผ่าน', criterium: Criterium.first())
Evaluation.create(id: 2, application: Application.last(), evaluator: 'ผู้คุม', evaluation_date: 1.year.ago, result: false, description: 'ไม่ผ่าน', criterium: Criterium.last())
