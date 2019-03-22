class CreatePublicComments < ActiveRecord::Migration[5.2]
  def change
    create_table :public_comments do |t|
      t.string :route_no
      t.references :route
      t.string :car_plate
      t.references :car
      t.string :licensee_name
      t.references :licensee
      t.text :comment
      t.string :commenter
      t.string :commenter_contact
      t.string :commenter_address

      t.timestamps
    end
  end
end
