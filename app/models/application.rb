class Application < ApplicationRecord
  enum state: [ :applying,
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
  has_many :attachments

  #scope
  scope :to_be_confirmed, -> { where(state: :registered) }
  scope :latest_confirmed, -> { where(state: [:confirmed,:applying]).where('confirmed_date >= ?',30.days.ago) }

  scope :to_be_appointed, -> { where(state: :confirmed, appointment_date: nil) }
  scope :to_be_appointed_filled, -> { where(state: :confirmed).where.not(appointment_date: !nil) }

  scope :to_be_evaluated, -> { where(state: :submitted) }
  scope :to_be_evaluated_filled, -> { where(state: :submitted).where(id:1999) }
  scope :latest_evaluated, -> {where(state: [:confirmed, :evaluated]).where('evaluated_date >= ?',30.days.ago) }

  scope :to_be_awarded, -> {where(state: :evaluated) }
  scope :latest_awarded, -> {where(state: :awarded).where('awarded_date >= ?',30.days.ago) }

  def to_label
    "#{self.number} - #{self.state_text}"
  end

  #some getter for enum
  def category_text
    Application.category_enum_to_text(category)
  end

  def state_text
    Application.state_enum_to_text(state)
  end

  def route_start
    return 'ไม่ประจำทาง' if category3? or route == nil
    return route.start
  end

  def route_destination
    return '-' if category3? or route == nil
    return route.destination
  end

  def self.state_enum_to_text(enum)
    Application.enum_to_st(:state,enum)
  end

  def self.category_enum_to_text(enum)
    Application.enum_to_st(:category, enum)
  end

  def self.states_t
    states.map{|x| [Application.state_enum_to_text(x.first), x.first]}
  end

  def self.categories_t
    categories.map{|x| [Application.category_enum_to_text(x.first), x.first]}
  end

  #state manipulation
  def confirm_registration() self.confirmed_date = Time.zone.now; change_state(:confirmed)  end
  def reject_registration()  self.confirmed_date = Time.zone.now; change_state(:applying)  end
  def submit_for_approve()   change_state(:submitted)  end


  def reject_evidence(reason)
    self.evaluated_date = Time.zone.now()
    self.evaluation_result = reason
    change_state(:confirmed)
  end

  def evaluation_finish
    self.evaluated_date = Time.zone.now()
    self.evaluation_result = ''
    change_state(:evaluated)
  end

  def sorted_attachments
    return attachments.includes(:criterium_attachment => [:criterium => :criteria_group]).order('criteria_groups.id, criteria.number')
  end

  def evaluated_count
    evaluations.where.not(result: nil).count
  end

  def add_missing_evaluation
    Criterium.where.not(id: Evaluation.select(:criterium_id).where(application: self)).each do |cri|
      evaluations << Evaluation.new(criterium_id: cri.id)
    end
  end

  def add_missing_attachments
    CriteriumAttachment.where.not(id: Attachment.select(:criterium_attachment_id).where(application: self)).each do |cri|
      attachments << Attachment.new(criterium_attachment_id: cri.id)
    end
  end

  def total_score
    return '85/100'
  end

  def passed
    return "ผ่าน 26 ไม่ผ่าน 1"
  end

  def change_state(new_state)
    self.state = new_state
    self.save
  end

end
