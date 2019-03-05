class AddMimeTypeToAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :mime_type, :string
  end
end
