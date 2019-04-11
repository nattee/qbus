class Announcement < ApplicationRecord
  belongs_to :user
  has_one_attached :main_attachment
  has_many_attached :other_attachments

  validates :main_attachment, content_type: Rails.configuration.attachment_content_type, size: { less_than: Rails.configuration.attachment_max_size}
  validates :other_attachments, content_type: Rails.configuration.attachment_content_type, size: { less_than: Rails.configuration.attachment_max_size}, limit: { max: Rails.configuration.attachment_max_file }

  scope :publishes, -> { where(published: true) }

end
