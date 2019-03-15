class Attachment < ApplicationRecord

  enum attachment_type: [:criterium_evidence, :contract, :signup]

  has_one_attached :data
  belongs_to :application
  belongs_to :criterium_attachment, optional: true

  def self.attachment_type_enum_to_text(enum)
    Attachment.enum_to_st(:attachment_type,enum)
  end

  def self.attachment_types_t
    attachment_types.map{|x| [Attachment.attachment_type_enum_to_text(x.first), x.first]}
  end

end
