class Application < ApplicationRecord
  enum state: [ :appying,
                :applied,
                :approved,
                :appointed,
                :surveyed,
                :evaluated
              ]

  enum category: [ :category1, :category2, :category3 ]

  #association
  belongs_to :route, optional: true
  belongs_to :licensee, optional: true
  belongs_to :user, optional: true
  has_many :evaluations

  #scope
  scope :to_be_appointed, -> { where(state: :approved) }

  def category_text
    Application.enum_to_st(:category,category)
  end

end
