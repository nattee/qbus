class ProcessController < ApplicationController
  before_action :set_application, only: [ :register_post, :registered, :registered_post,
                                          :appointment_post, :appointed,
                                          :evaluation, :evaluation_post, :evaluation_detail_post,
                                          :award, :award_post,
                                        ]


  def dashboard
    @to_be_appointed = Application.to_be_appointed
    @to_be_appointed_filled = Application.to_be_appointed_filled
    @to_be_evaluated = Application.to_be_evaluated
    @to_be_awarded = Application.to_be_awarded
  end

  def registered_index
    @to_be_confirmed = Application.to_be_confirmed
    @latest_confirmed = Application.latest_confirmed
  end

  def registered_post
    if params[:result] == 'yes'
      @application.register_reuslt = 'ใบสมัครถูกต้อง'
      @application.confirm_registration
    else
      @application.register_result = "ใบสมัครไม่ถูกต้อง #{params[:register_result]}"
      @application.reject_registration
    end
    redirect_to process_registers_path
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

  def evaluation_index
    @to_be_evaluated = Application.to_be_evaluated
    @to_be_evaluated_filled = Application.to_be_evaluated_filled
  end

  def evaluation
    @application.add_missing_evaluation
  end

  def evaluation_post
    #save evaluations
    @application.evaluations.each do |ev|
      case params.require(:result)[ev.id.to_s]
      when 'ok'
        ev.result = true
      when 'no'
        ev.result = false
      else
        ev.result = nil
      end
      ev.description = params.require(:description)[ev.id.to_s]
      ev.save
    end

    #save result
    if params[:eval_result] == 'ok'
      @application.evaluation_finish
    else
      @application.reject_evidence(params[:evaluation_result])
    end

    redirect_to process_evaluations_path

  end

  def evaluation_detail_post
  end

  def award_index
    @to_be_awarded = Application.to_be_awarded
    @awarded_recent = Application.awarded_recent
  end

  def award
  end

  def award_post
  end

  private
    def set_application
      @application = Application.find(params[:id])
    end
end
