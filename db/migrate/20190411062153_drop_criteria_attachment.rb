class DropCriteriaAttachment < ActiveRecord::Migration[5.2]
  def change
    remove_reference :attachments, :criterium_attachment
    drop_table :criterium_attachments
  end
end
