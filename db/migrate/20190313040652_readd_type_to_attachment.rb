class ReaddTypeToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :attachment_type, :int
  end
end
