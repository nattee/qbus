class Application < ApplicationRecord
  enum state: [ :preregister,
                :apply,
                :approved,
                :appointed,
                :surveyed,
                :evaluated
              ]

  #association
  belongs_to :route, optional: true
  belongs_to :licensee, optional: true
  belongs_to :user, optional: true
  has_many :evaluations

end
