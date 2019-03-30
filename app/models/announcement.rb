class Announcement < ApplicationRecord
  belongs_to :user
  has_one :attachment

  scope :publishes, -> { where(published: true) }

  def attach_file(attachment_params)
    if attachment_params['data'] == nil
      return false
    end
    file = Attachment.find_by(announcement_id: self.id, attachment_type: :announcement)
    if (file == nil)
      file = Attachment.new({attachment_type: :announcement, filename: attachment_params['file_name']})
      file.data.attach(attachment_params['data'])
      self.attachment = file
    else
      file.data.attach(attachment_params['data'])
      file.filename = attachment_params['file_name']
      file.save
    end
    return self.save && file.data.attached?
  end
end
