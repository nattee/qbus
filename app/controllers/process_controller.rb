class ProcessController < ApplicationController
  before_action :set_application, only: [ :registered, :registered_post,
                                          :appointment_post, :appointed, :appointment_visit, :appointment_visit_post,
                                          :evaluation, :evaluation_post, :evaluation_finish, :evaluation_reject,
                                          :award, :award_post,
                                        ]
  before_action :logged_in_user

  before_action only: [ :registered_index, :registered, :registered_post] do
    logged_in_with_role( [:verifier] )
  end

  before_action only: [ :appointment_index, :appointment_post, :appointed, :appointment_visit, :appointment_visit_post ] do
    logged_in_with_role( [:surveyor] )
  end

  before_action only: [ :evaluation_index, :evaluation, :evaluation_post, :evaluation_finish, :evaluation_reject] do
    logged_in_with_role( [:evaluator] )
  end

  before_action only: [ :award_index, :award, :award_post ] do
    logged_in_with_role( [:committee] )
  end

  before_action only: [
                        :registered, :registered_post,
                        :appointment_post, :appointed, :appointment_visit, :appointment_visit_post,
                        :evaluation, :evaluation_post, :evaluation_finish, :evaluation_reject,
                        :award, :award_post,
                      ] do
    can_access_app_by_province(@application)
  end

  def dashboard
    #for licensee
    @applying = Application.on_applying(@current_user)
    @need_evidences = Application.need_evidence(@current_user)
    @finished = Application.finished(@current_user)
    @waiting_official = Application.waiting_official(@current_user)

    #for officer & admin
    if @current_user.can_view_all_provinces?
      @to_be_confirmed = Application.to_be_confirmed
      @to_be_appointed = Application.to_be_appointed
      @to_be_appointed_filled = Application.to_be_appointed_filled
      @to_be_visited = Application.to_be_visited
      @to_be_evaluated = Application.to_be_evaluated
      @to_be_awarded = Application.to_be_awarded
    else
      @to_be_confirmed = Application.to_be_confirmed.where('license_no LIKE ?',"#{@current_user.province}%")
      @to_be_appointed = Application.to_be_appointed.where('license_no LIKE ?',"#{@current_user.province}%")
      @to_be_appointed_filled = Application.to_be_appointed_filled.where('license_no LIKE ?',"#{@current_user.province}%")
      @to_be_visited = Application.to_be_visited.where('license_no LIKE ?',"#{@current_user.province}%")
      @to_be_evaluated = Application.to_be_evaluated.where('license_no LIKE ?',"#{@current_user.province}%")
      @to_be_awarded = Application.to_be_awarded.where('license_no LIKE ?',"#{@current_user.province}%")
    end
  end

  #-------- verifier -----------------
  def registered_index
    if @current_user.can_view_all_provinces?
      @to_be_confirmed = Application.to_be_confirmed
      @latest_confirmed = Application.latest_confirmed
    else
      @to_be_confirmed = Application.to_be_confirmed.where('license_no LIKE ?',"#{@current_user.province}%")
      @latest_confirmed = Application.latest_confirmed.where('license_no LIKE ?',"#{@current_user.province}%")
    end
  end

  def registered

  end

  def registered_post
    if params[:result] == 'ok'
      @application.confirm_result = true
      @application.confirm_comment = "ใบสมัครถูกต้อง"
      @application.confirm_registration
    elsif params[:result] == 'no'
      comment = params[:confirm_comment].strip
      if comment.blank?
        redirect_to process_register_path(@application), flash: {error: "ในกรณีที่ไม่ผ่านการตรวจ จะต้องระบุคำอธิบาย"}
        return
      else
        @application.confirm_result = false
        @application.confirm_comment = "#{params[:confirm_comment]}"
        @application.reject_registration
      end
    else
      redirect_to process_register_path(@application), flash: {error: "โปรดระบุผลการตรวจ"}
      return
    end
    redirect_to process_registers_path, notice: "บันทึกผลการตรวจใบสมัครหมายเลข #{@application.id_text} เรียบร้อย"
  end


  #-------- surveyor -----------------
  def appointment_index
    if @current_user.can_view_all_provinces?
      @to_be_appointed = Application.to_be_appointed
      @to_be_appointed_filled = Application.to_be_appointed_filled
      @to_be_visited = Application.to_be_visited
      @latest_visited = Application.latest_visited
    else
      @to_be_appointed = Application.to_be_appointed.where('license_no LIKE ?',"#{@current_user.province}%")
      @to_be_appointed_filled = Application.to_be_appointed_filled.where('license_no LIKE ?',"#{@current_user.province}%")
      @to_be_visited = Application.to_be_visited.where('license_no LIKE ?',"#{@current_user.province}%")
      @latest_visited = Application.latest_visited.where('license_no LIKE ?',"#{@current_user.province}%")
    end
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
    @application.add_missing_evaluation
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
      if @application.evaluation_visit_all_evaluated
        @application.visited = true
        @application.visited_confirm_date = Time.zone.now
      else
        @application.save
        redirect_to appointment_visit_path(@application), flash: {notice: 'บันทึกผลการตรวจหน้างานเรียบร้อย', error: 'ไม่สามารถยืนยันการตรวจหน้างานได้ เนื่องจากยังประเมินไม่ครบทุกรายการ' }
        return
      end
    end

    @application.save

    if params[:confirm]
      redirect_to process_appointments_path, notice: 'ยืนยันผลการตรวจหน้างานเรียบร้อย'
    else
      redirect_to appointment_visit_path(@application), notice: 'บันทึกผลการตรวจหน้างานเรียบร้อย'
    end
  end

  #-------- evaluator -----------------
  def evaluation_index

    if @current_user.can_view_all_provinces?
      @to_be_evaluated = Application.to_be_evaluated
      @latest_evaluated = Application.latest_evaluated
    else
      @to_be_evaluated = Application.to_be_evaluated.where('license_no LIKE ?',"#{@current_user.province}%")
      @latest_evaluated = Application.latest_evaluated.where('license_no LIKE ?',"#{@current_user.province}%")
    end
  end

  def evaluation
    @application.add_missing_evaluation
  end

  def evaluation_post
    #save evaluations
    ev_result = application_evaluation_params
    @application.evaluation_main.each do |ev|
      if ['1','0.67','0.5', '0.33', '0'].include? ev_result[ev.id.to_s]
        ev.result = ev_result[ev.id.to_s].to_f
      end
      ev.description = params.require(:description)[ev.id.to_s]
      ev.save
    end

    if params[:confirm]
      if @application.evaluated_count < Criterium.need_evaluation.count
        redirect_to process_evaluation_path(@application), flash: {error: 'ยังประเมินไม่ครบทุกหัวข้อ'}
      else
        @application.evaluation_finish
        redirect_to process_evaluations_path, notice: 'ยืนยันผลการประเมินเรียบร้อย'
      end
    else
      redirect_to process_evaluation_path(@application), notice: 'บันทึกผลการประเมินเรียบร้อย'
    end
  end

  def evaluation_finish
  end

  def evaluation_reject
    @application.reject_evidence(params[:evaluation_result])
    redirect_to process_evaluations_path
  end

  #--------------- committee ---------------------------
  def award_index
    if @current_user.can_view_all_provinces?
      @to_be_awarded = Application.to_be_awarded
      @awarded_recent = Application.latest_awarded
    else
      @to_be_awarded = Application.to_be_awarded.where('license_no LIKE ?',"#{@current_user.province}%")
      @awarded_recent = Application.latest_awarded.where('license_no LIKE ?',"#{@current_user.province}%")
    end
  end

  def award
  end

  def award_post
    if params[:result] == 'ok'
      @application.award = 'ได้รับตราสัญลักษณ์'
      @application.award_won = true
      @application.award_expire_date = Time.zone.now + 3.year
    elsif params[:result] == 'no'
      @application.award = 'ไม่ได้รับตราสัญลักษณ์'
      @application.award_won = false
      @application.award_remark = params[:award_remark]
    else
    end
    @application.set_award
    redirect_to process_awards_path, notice: "บันทึกการตัดสินผลเรียบร้อย"
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
