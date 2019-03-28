class AddPublishedToAnnouncement < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :published, :boolean, default: false
  end
end
