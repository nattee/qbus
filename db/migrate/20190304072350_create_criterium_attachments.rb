class CreateCriteriumAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :criterium_attachments do |t|
      t.string :name
      t.text :description
      t.references :criterium, foreign_key: false
      t.boolean :required

      t.timestamps
    end
  end
end
