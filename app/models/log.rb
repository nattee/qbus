class Log < ApplicationRecord
  belongs_to :application, optional: true
end
