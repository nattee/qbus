class AddPriorityToAnnouncement < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :priority, :int, default: 0
  end
end
