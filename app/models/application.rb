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
  belongs_to :extend_app, class_name: :Application, optional: true
  has_many :evaluations, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :logs, dependent: :nullify

  #for user
  scope :applying, -> { where(state: :applying) }
  scope :waiting_evidence, -> { where(state: :confirmed) }

  #for officer
  scope :to_be_confirmed, -> { where(state: :registered) }
  scope :latest_confirmed, -> { where(state: [:confirmed,:applying]).where('confirmed_date >= ?',30.days.ago) }


  scope :to_be_appointed, -> { where(state: [:confirmed, :submitted], appointment_date: nil).where(visited: [false,nil]) }
  scope :to_be_appointed_filled, -> { where(state: [:confirmed, :submitted]).where.not(appointment_date: !nil) }
  scope :to_be_visited, -> { where(state: [:confirmed, :submitted]).where(visited: [false,nil]) }
  scope :latest_visited, -> {where('visited_confirm_date >= ?',30.days.ago) }

  scope :to_be_evaluated, -> { where(state: :submitted) }
  scope :to_be_evaluated_filled, -> { where(state: :submitted).where(id:1999) }
  scope :latest_evaluated, -> {where(state: [:confirmed, :evaluated]).where('evaluated_date >= ?',30.days.ago) }

  scope :to_be_awarded, -> {where(state: :evaluated) }
  scope :finished, -> {where(state: :awarded) }
  scope :latest_awarded, -> {where(state: :awarded).where('awarded_date >= ?',30.days.ago) }

  scope :won_award, -> {where(state: :awarded).where(award_won: true) }

  def to_label
    "#{self.number} - #{self.state_text}"
  end

  def id_text
    return "%05d" % id
  end

  #some getter
  def category_text
    Application.category_enum_to_text(category)
  end

  def state_text
    Application.state_enum_to_text(state)
  end

  def route_no
    return 'ไม่ประจำทาง' if category3? or route == nil
    return route.route_no
  end

  def route_start
    return '' if category3? or route == nil
    return route.start
  end

  def route_destination
    return '' if category3? or route == nil
    return route.destination
  end

  def route_info
    return '-' if category3? or route == nil
    return "#{route.start} - #{route.destination}"
  end

  def total_score
    sum = 0.0
    evaluations.joins(:criterium => :criteria_group).where("criteria_groups.id <= 6").each do |ev|
      sum += (ev.result || 0) * ev.criterium.weight
    end
    return sum.to_i
  end

  def total_score_text
    "#{total_score}/100"
  end

  def safety_score
    sum = 0.0
    evaluations.joins(:criterium => :criteria_group).where("criteria_groups.id in (5,6)").each do |ev|
      sum += (ev.result || 0) * ev.criterium.weight
    end
    return sum.to_i
  end

  def safety_score_text
    "#{safety_score}/30"
  end


  def passed
    a = total_score
    b = safety_score
    if (a < 80) or (b < 25) or (fail_visit?)
      return "ไม่ผ่าน"
    end
    return "ผ่าน"
  end

  #
  # visit tasks
  #
  def visit_evaluation_fail_count
    evaluation_visit.where(result: [0,nil]).count
  end

  def evaluation_visit_all_evaluated
    evaluation_visit.where(result: [nil]).count == 0
  end

  def fail_visit?
    return visit_evaluation_fail_count > 0
  end

  def visit_summary_text
    return 'ไม่่ผ่าน' if visit_evaluation_fail_count > 0
    return 'ผ่าน'
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

  def get_attachment(type)
    attachments.where(attachment_type: type).first
  end

  def count_missing_attachments
    result = {has: [],total: 0, present: 0}
    CriteriaGroup.need_evidence.each do |cg|
      total = 0
      present = 0
      cg.criterium.each do |ci|
        ci.evidences.each do |ev|
          c =  attachments.where(evidence: ev).count
          result[:has][ev.id] = true if c > 0
          total += 1
          present += c
        end
      end
      result[:total] += total
      result[:present] += present
      result[cg.id] = {total: total, present: present}
    end
    #hard code for checking all evidence of cri 1.1
    if result[:has][1] and result[:has][2] and result[:has][3]
      result[:cri11ok] = true
    else
      result[:cri11ok] = false
    end
    return result
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

  def confirm_award(result, remark)
    self.award_won = result
    self.award_remark = remark
    set_award
  end

  def use_licensee(licensee)
    self.licensee = licensee
    self.contact = licensee.contact if self.contact.blank?
    self.contact_tel = licensee.contact_tel if self.contact_tel.blank?
    self.contact_email = licensee.contact_email if self.contact_email.blank?
  end

  def evaluated_count
    evaluation_main.where.not(result: nil).count
  end

  def add_missing_evaluation
    Criterium.where.not(id: Evaluation.select(:criterium_id).where(application: self)).each do |cri|
      evaluations << Evaluation.new(criterium_id: cri.id)
    end
  end

  def evaluation_main
    evaluations.joins(:criterium => :criteria_group).where('criteria_groups.id <= 6').order('criteria_groups.id, criteria.number')
  end

  #return self evaluations
  def self_evaluations
    if category3?
      return evaluations.joins(:criterium => :criteria_group).where("criteria_groups.id = 8")
    else
      return evaluations.joins(:criterium => :criteria_group).where("criteria_groups.id in (7,8)")
    end
  end

  def evaluation_visit
    evaluations.joins(:criterium => :criteria_group).where('criteria_groups.id = 9')
  end

  def evaluation_visit_sec2
    evaluations.joins(:criterium => :criteria_group).where('criteria_groups.id = 9').order('criteria.id').limit(5)
  end

  def evaluation_visit_sec3
    evaluations.joins(:criterium => :criteria_group).where('criteria.id = 50').order('criteria.id')
  end

  def evaluation_visit_sec4
    evaluations.joins(:criterium => :criteria_group).where('criteria.id = 51').order('criteria.id')
  end

  def evaluation_visit_sec5
    evaluations.joins(:criterium => :criteria_group).where('criteria_groups.id = 9 and criteria.id > 51').order('criteria.id')
  end

  def attach_data(attachment_type, params)
    att = attachments.where(attachment_type: attachment_type).first
    filename_param = "#{attachment_type.to_s}_file_name"
    data_param = "#{attachment_type.to_s}_data"
    if att
      att.data.attach(params[data_param])
      att.filename = params[filename_param]
      att.save
    else
      att = Attachment.new({attachment_type: attachment_type, filename: params[filename_param]})
      att.data.attach(params[data_param])
      attachments << att
    end
    return save && att.data.attached?
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



  def change_state(new_state)
    self.state = new_state
    self.save
  end

  def self.extend(original)
    app = original.dup

    #copy attachment
    original.attachments.where.not(evidence_id: nil).each do |att|
      #copy attachment
      new_att = att.dup
      new_att.data.attach io: StringIO.new(att.data.download),
                          filename: att.data.filename,
                          content_type: att.data.content_type
      new_att.save

      app.attachments << new_att
    end

    app.extend = true
    app.extend_app = original

    #link car (must no deep copy)
    app.cars = original.cars

    #evaluation? no!!! we need them to do self evaluation again
    app.evaluations.delete_all
    up_value = {}
    (1..4).each do |m|
      ['chassis','tire','light','windshield'].each do |t|
        prop = "visit_car#{m}_#{t}"
        up_value[prop.to_sym] = nil
      end
    end
    app.update(up_value)
    app.state = :applying
    app.save
    app.add_missing_evaluation
    return app
  end

end
