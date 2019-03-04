class RemoveTypeFromAttachments < ActiveRecord::Migration[5.2]
  def change
    remove_column :attachments, :type, :integer
  end
end
