class Attachment < ApplicationRecord

  enum attachment_type: [:criterium_evidence, :contract, :qbus_signup]

  has_one_attached :data
  belongs_to :application
  belongs_to :criterium_attachment, optional: true
end
