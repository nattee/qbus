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
  scope :to_be_appointed, -> { where(state: :approved, appointment_date: nil) }
  scope :to_be_appointed_filled, -> { where(state: :approved).where.not(appointment_date: !nil) }
  scope :to_be_evaluated, -> { where(state: :appointed) }

  def category_text
    Application.enum_to_st(:category,category)
  end

  def evaluated_count
    evaluations.where.not(result: nil).count
  end

end
