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
  has_many :cars

  #scope
  #for user
  scope :applying, -> { where(state: :applying) }
  scope :waiting_evidence, -> { where(state: :confirmed) }

  #for officer
  scope :to_be_confirmed, -> { where(state: :registered) }
  scope :latest_confirmed, -> { where(state: [:confirmed,:applying]).where('confirmed_date >= ?',30.days.ago) }


  scope :to_be_appointed, -> { where(state: [:confirmed, :submitted], appointment_date: nil) }
  scope :to_be_appointed_filled, -> { where(state: [:confirmed, :submitted]).where.not(appointment_date: !nil) }

  scope :to_be_evaluated, -> { where(state: :submitted) }
  scope :to_be_evaluated_filled, -> { where(state: :submitted).where(id:1999) }
  scope :latest_evaluated, -> {where(state: [:confirmed, :evaluated]).where('evaluated_date >= ?',30.days.ago) }

  scope :to_be_awarded, -> {where(state: :evaluated) }
  scope :finished, -> {where(state: :awarded) }
  scope :latest_awarded, -> {where(state: :awarded).where('awarded_date >= ?',30.days.ago) }

  def to_label
    "#{self.number} - #{self.state_text}"
  end

  #some getter
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

  def appoint_date
    return I18n.localize(appointment_date, format: '%d %b %Y') if appointment_date
    return 'ยังไม่ได้นัดหมาย'
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
  def submit_for_approve()   self.submitted_date = Time.zone.now; change_state(:submitted)  end
  def set_award()            self.awarded_date = Time.zone.now; change_state(:awarded)  end


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
    return attachments.where(attachment_type: :criterium_evidence).includes(:criterium_attachment => [:criterium => :criteria_group]).order('criteria_groups.id, criteria.number')
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
    #CriteriumAttachment.where.not(id: Attachment.select(:criterium_attachment_id).where(application: self)).each do |cri|
    #  attachments << Attachment.new(criterium_attachment_id: cri.id, attachment_type: :criterium_evidence)
    #end
  end

  def attach_signup_data(signup_params)
    signup = Attachment.find_by(application_id: self.id, attachment_type: :signup)
    if (signup == nil)
      signup = Attachment.new({attachment_type: :signup, filename: signup_params['signup_file_name']})
      signup.data.attach(signup_params['signup_data'])
      attachments << signup
    else
      signup.data.attach(signup_params['signup_data'])
      signup.filename = signup_params['signup_file_name']
      signup.save
    end
    return save && signup.data.attached?
  end

  def attach_contract_data(contract_params)
    contract = Attachment.find_by(application_id: self.id, attachment_type: :contract)
    if (contract == nil)
      contract = Attachment.new({attachment_type: :contract, filename: contract_params['contract_file_name']})
      contract.data.attach(contract_params['contract_data'])
      attachments << contract
    else
      contract.data.attach(contract_params['contract_data'])
      contract.filename = contract_params['contract_file_name']
      contract.save
    end
    return save && contract.data.attached?
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
