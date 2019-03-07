class RemoveDataFromAttachment < ActiveRecord::Migration[5.2]
  def change
    remove_column :attachments, :mime_type, :string
    remove_column :attachments, :data, :binary
  end
end
