class RemoveAnnouncementFromAttachment < ActiveRecord::Migration[5.2]
  def change
    remove_reference :attachments, :announcement
  end
end
