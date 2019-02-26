class ProcessController < ApplicationController
  before_action :set_application, only: [ :appointment_post,
                                        ]
  def appointment_index
    @to_be_appointed = Application.to_be_appointed
    @to_be_appointed_filled = Application.to_be_appointed_filled
  end

  def appointment_post
    @application.appointment_date = params[:appointment_date]
    @application.appointment_remark = params[:appointment_remark]
    @application.save
    redirect_to process_appointment_path
  end

  def evaluation_index
  end

  def evaluation
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