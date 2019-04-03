class AddVisitToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :visit_problem, :text
    add_column :applications, :visit_problem_cause, :text
    add_column :applications, :visit_tax_accrued, :text
    add_column :applications, :visit_tax_89, :text
    add_column :applications, :visit_result, :text
    add_column :applications, :visit_comment, :text
    add_column :applications, :visit_car1_chassis, :string
    add_column :applications, :visit_car1_tire, :string
    add_column :applications, :visit_car1_light, :string
    add_column :applications, :visit_car1_windshield, :string
    add_column :applications, :visit_car2_chassis, :string
    add_column :applications, :visit_car2_tire, :string
    add_column :applications, :visit_car2_light, :string
    add_column :applications, :visit_car2_windshield, :string
    add_column :applications, :visit_car3_chassis, :string
    add_column :applications, :visit_car3_tire, :string
    add_column :applications, :visit_car3_light, :string
    add_column :applications, :visit_car3_windshield, :string
    add_column :applications, :visit_car4_chassis, :string
    add_column :applications, :visit_car4_tire, :string
    add_column :applications, :visit_car4_light, :string
    add_column :applications, :visit_car4_windshield, :string
  end
end
