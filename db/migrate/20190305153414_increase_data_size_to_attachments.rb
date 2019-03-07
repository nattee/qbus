class IncreaseDataSizeToAttachments < ActiveRecord::Migration[5.2]
  def change
    change_column :attachments, :data, :binary, :limit => 5.megabyte
  end
end
