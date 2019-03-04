class Attachment < ApplicationRecord
  belongs_to :application
  belongs_to :criterium_attachment, optional: true
end
