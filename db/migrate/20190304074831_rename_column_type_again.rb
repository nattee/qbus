class RenameColumnTypeAgain < ActiveRecord::Migration[5.2]
  def change
    change_table :attachments do |t|
      t.rename :type, :attachment_type
    end
  end
end
