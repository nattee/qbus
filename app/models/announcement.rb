class Announcement < ApplicationRecord
  belongs_to :user
  has_one :attachment
end
