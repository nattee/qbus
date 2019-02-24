class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :filename
      t.integer :type
      t.blob :data

      t.timestamps
    end
  end
end
