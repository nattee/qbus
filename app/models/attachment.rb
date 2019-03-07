class Attachment < ApplicationRecord
  has_one_attached :data
  belongs_to :application
  belongs_to :criterium_attachment, optional: true
end
