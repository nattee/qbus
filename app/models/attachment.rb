class Attachment < ApplicationRecord

  enum attachment_type: [:evidence, :contract, :signup, :license, :b11]

  has_one_attached :data
  belongs_to :application, optional: true
  belongs_to :evidence, optional: true

  validates :data, attached: true, content_type: Rails.configuration.attachment_content_type, size: { less_than: Rails.configuration.attachment_max_size}

  def self.attachment_type_enum_to_text(enum)
    Attachment.enum_to_st(:attachment_type,enum)
  end

  def self.attachment_types_t
    attachment_types.map{|x| [Attachment.attachment_type_enum_to_text(x.first), x.first]}
  end

  def attachment_type_text
    Attachment.attachment_type_enum_to_text(attachment_type)
  end

end
