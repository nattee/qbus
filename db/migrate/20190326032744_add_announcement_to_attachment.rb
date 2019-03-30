class AddAnnouncementToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_reference :attachments, :announcement
  end
end
