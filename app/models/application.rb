class Application < ApplicationRecord
  enum state: [ :preregister,
                :apply,
                :approved,
                :appointed,
                :surveyed,
                :evaluated
              ]
end
