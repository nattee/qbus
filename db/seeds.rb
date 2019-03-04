# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all;
User.create(id: 1, name: 'test1@gmail.com', email: 'test1@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: '{"admin": "1", "verifier": "1", "surveyor": "0"}')
User.create(id: 2, name: 'test2@gmail.com', email: 'test2@gmail.com', password_digest: User.digest('testtest'), activated: true, activated_at: 1.month.ago, roles: '{"admin": "0", "verifier": "0", "surveyor": "1"}')

Licensee.delete_all;
Licensee.create(id: 1, name: 'ผู้ประกอบการหนึ่ง', license_no: 'หมายเลขผู้ประกอบการหนึ่ง', license_expire: 5.year.from_now, car_count: '100', contact: 'เจ้านายผู้ประกบอการ', contact_tel: '0123456789')
Licensee.create(id: 2, name: 'ผู้ประกอบการสอง', license_no: 'หมายเลขผู้ประกอบการสอง', license_expire: 5.year.from_now, car_count: '10', contact: 'ลูกน้องผู้ประกบอการ', contact_tel: '0987654321')

Route.delete_all;
Route.create(id: 1, name: 'เส้นทางที่หนึ่ง', start: 'ป้ายแรก', destination: 'ป้ายสุดท้าย', car_count: 10, route_type: 'รถเมล์')
Route.create(id: 2, name: 'เส้นทางที่สอง', start: 'ป้ายแรกแรก', destination: 'ป้ายท้ายท้าย', car_count: 10, route_type: 'รถสองแถว')

Car.delete_all;
Car.create(id: 1, plate: 'เลขทะเบียนรถหนึ่ง', chassis: 'เลขตัวรถหนึ่ง', licensee: Licensee.first(), route: Route.first())
Car.create(id: 2, plate: 'เลขทะเบียนรถสอง', chassis: 'เลขตัวรถสอง', licensee: Licensee.last(), route: Route.last())

Datafile.delete_all;
Datafile.create(id: 1, name: 'ไฟล์ข้อมูลหนึ่ง', month_year: 1.year.ago, user: User.first() )
Datafile.create(id: 2, name: 'ไฟล์ข้อมูลสอง', month_year: 1.month.ago, user: User.last() )

Violation.delete_all;
Violation.create(id: 1, car: Car.first(), count: 10, month_year: Time.zone.now, datafile: Datafile.first())
Violation.create(id: 2, car: Car.last(), count: 20, month_year: Time.zone.now, datafile: Datafile.last())

CriteriaGroup.delete_all;
CriteriaGroup.create(id: 1, name: 'ข้อกำหนดด้านองค์กรและการบริหารจัดการ',group_weight: 15)
CriteriaGroup.create(id: 2, name: 'ข้อกำหนดด้านปฏิบัติงาน',group_weight: 15)
CriteriaGroup.create(id: 3, name: 'ข้อกำหนดด้านยานหาพนะ',group_weight: 20)
CriteriaGroup.create(id: 4, name: 'ข้อกำหนดด้านพนักงาน',group_weight: 20)
CriteriaGroup.create(id: 5, name: 'ข้อกำหนดด้านความปลอดภัย',group_weight: 30)

Criterium.delete_all;
Criterium.create(number: 1, name: 'มีโครงสร้างการบริหารงานที่ชัดเจน', criteria_group_id: 1,weight: 20)
Criterium.create(number: 2, name: 'มีการกำหนดนโยบายและวิสัยทัศน์ ด้านการควบคุมการใช้สารเสพติดและแอลกอฮอล์ อย่างชัดเจน', criteria_group_id: 1,weight: 20)
Criterium.create(number: 3, name: 'มีการกำหนดตัวชี้วัดประสิทธิภาพในการบริหารงาน', criteria_group_id: 1,weight: 20)
Criterium.create(number: 4, name: 'มีช่องทางรับข้อเสนอแนะและข้อร้องเรียนจากลูกค้า และการประเมินระดับความพึงพอใจของลูกค้า', criteria_group_id: 1,weight: 20)
Criterium.create(number: 5, name: 'ได้การรับรองมาตรฐานสากล (ISO) ด้านต่าง ๆ เช่น ISO 9001 ISO 14001 หรือรางวัลต่าง ๆ', criteria_group_id: 1,weight: 20)

Criterium.create(number: 1, name: 'มีการกำหนดขั้นตอนการปฏิบัติงานและคู่มือการปฏิบัติงาน', criteria_group_id: 2,weight: 20)
Criterium.create(number: 2, name: 'มีการลงบันทึกสมุดพนักงานขับรถ/สมุดประจำรถ หรือบันทึกการปฏิบัติงานขนส่ง เพื่อเป็นหลักฐานการใช้รถขนส่งทุกครั้ง', criteria_group_id: 2,weight: 20)
Criterium.create(number: 3, name: 'มีแผนการจัดตารางการเดินรถและการเข้างานของพนักงานที่ชัดเจน', criteria_group_id: 2,weight: 20)
Criterium.create(number: 4, name: 'มีการบันทึกผลการปฏิบัติงานที่แสดงประสิทธิผลการดำเนินงานอย่างเหมาะสม', criteria_group_id: 2,weight: 20)
Criterium.create(number: 5, name: 'มีการบันทึกข้อมูลปริมาณการใช้เชื้อเพลิงโดยรวมทั้งหมู่ยานพาหนะและรายคัน', criteria_group_id: 2,weight: 20)

Criterium.create(number: 1, name: 'มีความพร้อมของอุปกรณ์ในการให้บริการ และอุปกรณ์เพื่อความปลอดภัย', criteria_group_id: 3,weight: 20)
Criterium.create(number: 2, name: 'มีการจัดทำประวัติการใช้รถและประวัติการซ่อมบำรุงของรถรายคัน', criteria_group_id: 3,weight: 20)
Criterium.create(number: 3, name: 'มีประกันภัยภาคสมัครใจ หรือประกันภัยส่วนบุคคลเพิ่มเติม​', criteria_group_id: 3,weight: 20)
Criterium.create(number: 4, name: 'มีการดูแลความสะอาดของรถโดยสารอย่างสม่ำเสมอ', criteria_group_id: 3,weight: 20)
Criterium.create(number: 5, name: 'อุปกรณ์ส่วนควบที่อยู่นอกเหนือข้อบังคับตามกฎหมายต่าง ๆ​', criteria_group_id: 3,weight: 20)

Criterium.create(number: 1, name: 'มีการกำหนดขั้นตอนการรับสมัครพนักงาน บันทึก และเก็บรักษาประวัติพนักงานอย่างเหมาะสม', criteria_group_id: 4,weight: 10)
Criterium.create(number: 2, name: 'มีระเบียบการรับสมัครพนักงานขับรถ', criteria_group_id: 4,weight: 10)
Criterium.create(number: 3, name: 'มีการแสดงกฎระเบียบและความรับผิดชอบของพนักงาน รวมถึงบทลงโทษ และประกาศให้พนักงานรับทราบอย่างทั่วถึง', criteria_group_id: 4,weight: 20)
Criterium.create(number: 4, name: 'มีการวางแผนกำหนดชั่วโมงทำงาน วันหยุด และดำเนินการอย่างเหมาะสม', criteria_group_id: 4,weight: 20)
Criterium.create(number: 5, name: 'มีแผนการฝึกอบรมทักษะและประสบการณ์พนักงาน และดำเนินการอย่างเหมาะสม', criteria_group_id: 4,weight: 20)
Criterium.create(number: 6, name: 'มีระบบการสร้างแรงจูงใจให้พนักงานมีจิตสำนึกในการทำงานที่ดี บรรลุเป้าหมาย', criteria_group_id: 4,weight: 20)
Criterium.create(number: 7, name: 'มีการสร้างเสริมสุขภาพของพนักงาน ตรวจสุขภาพและตรวจโรคที่เป็นอุปสรรคต่อการขับขี่ มีการบันทึกและเก็บรักษาผลอย่างเป็นระบบ', criteria_group_id: 4,weight: 20)

Criterium.create(number: 1, name: 'มีคู่มือการจัดการเหตุฉุกเฉินระหว่างการขนส่ง โดยแสดงขั้นตอนการปฏิบัติและข้อมูลต่าง ๆ ที่จำเป็นอย่างชัดเจน', criteria_group_id: 5,weight: 20)
Criterium.create(number: 2, name: 'มีการบันทึกข้อมูลการเกิดอุบัติเหตุต่าง ๆ อย่างต่อเนื่อง', criteria_group_id: 5,weight: 20)
Criterium.create(number: 3, name: 'มีการวางแผนอบรมพนักงานขับรถให้ขับขี่อย่างปลอดภัย  เป็นประจำ', criteria_group_id: 5,weight: 20)
Criterium.create(number: 4, name: 'มีการอบรมการตรวจสภาพและบำรุงรักษายานพาหนะเบื้องต้นสำหรับพนักงานขับรถ', criteria_group_id: 5,weight: 20)
Criterium.create(number: 5, name: 'มีแผนการป้องกันการเกิดอุบัติเหตุที่ชัดเจน', criteria_group_id: 5,weight: 20)
