class Application < ApplicationRecord
  enum state: [ :appying,
                :registered,
                :confirmed,
                :submitted,
                :evaluated,
                :awarded,
              ]

  enum category: [ :category1, :category2, :category3 ]

  #association
  belongs_to :route, optional: true
  belongs_to :licensee, optional: true
  belongs_to :user, optional: true
  belongs_to :appointment_user, :class_name => :User, :foreign_key => "appointment_user_id", optional: true
  has_many :evaluations

  #scope
  scope :to_be_confirmed, -> { where(state: :registered) }
  scope :latest_confirmed, -> { where(state: :confirmed).where('confirmed_date >= ?',30.days.ago) }
  scope :to_be_appointed, -> { where(state: :confirmed, appointment_date: nil) }
  scope :to_be_appointed_filled, -> { where(state: :confirmed).where.not(appointment_date: !nil) }
  scope :to_be_evaluated, -> { where(state: :submitted) }
  scope :to_be_awarded, -> {where(state: :evaluated) }

  #some getter for enum
  def category_text
    Application.enum_to_st(:category,category)
  end

  def state_text
    Application.enum_to_st(:state,state)
  end

  #state manipulation
  def confirm_registration() change_state(:confirmed)  end
  def submit_evidence()      change_state(:submitted)  end
  def reject_evidence()      change_state(:confirmed)  end

  def evaluated_count
    evaluations.where.not(result: nil).count
  end

  def add_missing_evaluation
    Criterium.where.not(id: Evaluation.select(:criterium_id).where(application: self)).each do  |cri|
      evaluations << Evaluation.new(criterium_id: cri.id)
    end
  end

  private
  def change_state(new_state)
    state = new_state
    save
  end

end
