class ProcessController < ApplicationController
  before_action :set_application, only: [ :registered, :registered_post,
                                          :appointment_post, :appointed, :appointment_visit, :appointment_visit_post,
                                          :evaluation, :evaluation_post, :evaluation_finish, :evaluation_reject,
                                          :award, :award_post,
                                        ]


  def dashboard
    @applying = Application.applying
    @need_evidences = Application.waiting_evidence
    @to_be_confirmed = Application.to_be_confirmed
    @to_be_appointed = Application.to_be_appointed
    @to_be_appointed_filled = Application.to_be_appointed_filled
    @to_be_evaluated = Application.to_be_evaluated
    @to_be_awarded = Application.to_be_awarded

    @to_be_done = @to_be_confirmed + @to_be_evaluated + @to_be_awarded
    @finished = Application.finished
  end

  def registered_index
    @to_be_confirmed = Application.to_be_confirmed
    @latest_confirmed = Application.latest_confirmed
  end

  def registered_post
    if params[:result] == 'ok'
      @application.register_result = 'ใบสมัครถูกต้อง'
      @application.confirm_registration
    elsif params[:result] == 'no'
      @application.register_result = "ใบสมัครไม่ถูกต้อง #{params[:register_result]}"
      @application.reject_registration
    else
    end
    redirect_to process_registers_path, notice: "บันทึกผลการตรวจใบสมัครหมายเลข #{@application.id} เรียบร้อย"
  end

  def registered

  end

  def appointment_index
    @to_be_appointed = Application.to_be_appointed
    @to_be_appointed_filled = Application.to_be_appointed_filled
  end

  def appointment_post
    @application.appointment_date = params[:appointment_date]
    @application.appointment_remark = params[:appointment_remark]
    @application.save
    redirect_to process_appointments_path
  end

  def appointed
    redirect_to process_appointments_path
  end

  def appointment_visit

  end

  def appointment_visit_post
    #save applications param
    @application.update(application_visit_params)

    #save evaluations
    ev_result = application_evaluation_params
    @application.evaluations.each do |ev|
      if ev_result[ev.id.to_s] == '1'
        ev.result = 1
      elsif ev_result[ev.id.to_s] == '0.5'
        ev.result = 0.5
      elsif ev_result[ev.id.to_s] == '0'
        ev.result = 0
      end
      ev.save
    end

    if params[:confirm]
      @application.visited = true
    end

    @application.save

    if params[:confirm]
      redirect_to process_appointments_path(@application), notice: 'ยืนยันผลการตรวจหน้างานเรียบร้อย'
    else
      redirect_to appointment_visit_path(@application), notice: 'บันทึกผลการตรวจหน้างานเรียบร้อย'
    end
  end

  def evaluation_index
    @to_be_evaluated = Application.to_be_evaluated
    @latest_evaluated = Application.latest_evaluated
  end

  def evaluation
    @application.add_missing_evaluation
  end

  def evaluation_post
    #save evaluations
    ev_result = application_evaluation_params
    @application.evaluation_main.each do |ev|
      if ev_result[ev.id.to_s] == '1'
        ev.result = 1
      elsif ev_result[ev.id.to_s] == '0.5'
        ev.result = 0.5
      elsif ev_result[ev.id.to_s] == '0'
        ev.result = 0
      end
      ev.description = params.require(:description)[ev.id.to_s]
      ev.save
    end
    redirect_to process_evaluation_path(@application), notice: 'บันทึกผลการประเมินเรียบร้อย'
  end

  def evaluation_finish
    @application.evaluation_finish
    redirect_to process_evaluations_path
  end

  def evaluation_reject
    @application.reject_evidence(params[:evaluation_result])
    redirect_to process_evaluations_path
  end

  def award_index
    @to_be_awarded = Application.to_be_awarded
    @awarded_recent = Application.latest_awarded
  end

  def award
  end

  def award_post
    if params[:result] == 'ok'
      @application.award = 'ได้รับตราสัญลักษณ์'
      @application.award_won = true
    elsif params[:result] == 'no'
      @application.award = 'ไม่ได้รับตราสัญลักษณ์'
      @application.award_won = false
      @application.award_remark = params[:award_remark]
    else
    end
    @application.set_award
    redirect_to process_dashboard_path, notice: "บันทึกการตัดสินผลเรียบร้อย"
  end

  private
    def set_application
      @application = Application.find(params[:id])
    end

    def application_visit_params
      params.require(:application).permit(:visited_date, :visitor, :visitor_tel, :visitor_email, :visitor_position,
                                          :visit_comment, :visit_problem, :visit_problem_cause, :visit_result, :visit_tax_89, :visit_tax_accrued,
                                          :visit_car1_chassis,:visit_car1_light,:visit_car1_tire,:visit_car1_windshield,
                                          :visit_car2_chassis,:visit_car2_light,:visit_car2_tire,:visit_car2_windshield,
                                          :visit_car3_chassis,:visit_car3_light,:visit_car3_tire,:visit_car3_windshield,
                                          :visit_car4_chassis,:visit_car4_light,:visit_car4_tire,:visit_car4_windshield)

    end

    def application_evaluation_params
      params.fetch(:result, {})
    end
end
