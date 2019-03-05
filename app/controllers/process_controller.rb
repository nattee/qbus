class ProcessController < ApplicationController
  before_action :set_application, only: [ :register_post, :registered, :registered_post,
                                          :appointment_post, :appointed,
                                          :evaluation, :evaluation_post
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
    @application.confirm_registration
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
  end

  def evaluation
    @application.add_missing_evaluation
  end

  def evaluation_post
  end

  def award_index
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
