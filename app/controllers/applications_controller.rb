class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy, :show_full,
                                         :apply_step1, :apply_step2, :apply_step3,:fail_self_evaluation,
                                         :post_step1,:post_step2,:post_step3,
                                         :add_evidences,:add_attachment,:finish_add_evidences,
                                         :add_car, :remove_car,
                                         :extend_from,
                                        ]

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
  end

  def apply
    @application = Application.new
  end

  def apply_step1

  end

  def apply_step2

  end

  def apply_step3
    @application.add_missing_evaluation
  end

  def post_apply
    @application = Application.new(application_params)

    if @application.save
      redirect_to apply_step1_application_path(@application)
    else
      redirect_to apply_applications_path
    end
  end

  def post_step1
    #routes and licensee data
    @application.update(application_params)

    unless @application.category3?
      @route = Route.where(route_no: route_params[:route_no]).first
      unless @route
        @route = Route.new(route_params)
        @route.save
      end
      @application.route = @route
    end

    @licensee = Licensee.where(name: licensee_params[:name]).first
    unless @licensee
      @licensee = Licensee.create(licensee_params) unless @licensee
      @licensee.update(contact: application_params[:contact],
                       contact_tel: application_params[:contact_tel],
                       contact_email: application_params[:contact_email])
    end

    @application.use_licensee(@licensee)
    @application.save

    att_param = attachment_contract_signup_params
    [:license,:contract,:signup].each do |att_sym|
      if att_param["#{att_sym.to_s}_data".to_sym]
        next if @application.attach_data(att_sym, att_param)
      else
        next if @application.get_attachment(att_sym)
      end
      redirect_to(apply_step1_application_path(@application), flash: {error: 'กรุณาแนบเอกสารให้ครบถ้วน'}) and return
    end

    if @application.save
      redirect_to apply_step2_application_path(@application)
    else
      redirect_to(apply_applications_path)
    end


  end

  def post_step2
    #car data

    #b11 attachment
    att_param = attachment_contract_signup_params
    if att_param[:b11_data]
      @application.attach_data(:b11, att_param)
    end

    if @application.save
      redirect_to apply_step3_application_path(@application)
    else
      redirect_to apply_applications_path
    end
  end

  def post_step3
    has_no = false
    ev_result = application_evaluation_params
    @application.self_evaluations.each do |ev|
      if ev_result[ev.id.to_s] == 'ok'
        ev.result = 1
      elsif ev_result[ev.id.to_s] == 'no'
        ev.result = 0
        has_no = true
      else
        has_no = true
      end
      ev.save
    end

    if has_no
      redirect_to fail_self_evaluation_application_path(@application)
    else
      @application.state = :registered
      if @application.save
        redirect_to process_dashboard_path , notice: 'สร้างใบสมัครเรียบร้อย'
      else
        redirect_to apply_applications_path
      end
    end
  end

  def add_car
    car = Car.new(plate: params[:plate], car_type: params[:car_type], province: params[:province], brand: params[:brand])
    @application.cars << car
    redirect_to apply_step2_application_path(@application)
  end

  def remove_car
    Car.where(id: params[:car_id], application_id: params[:id]).first()&.destroy
    redirect_to apply_step2_application_path(@application)
  end

  #attachment index
  def add_evidences
    @attachment = Attachment.new
  end

  #post
  def add_attachment
    unless attachment_params[:data]
      redirect_to add_evidences_application_path(@application), flash: { error: "แนบหลักฐานไม่สำเร็จ ท่านไม่ได้เลือกไฟล์ที่ถูกต้อง"}
      return
    end
    @attachment = @application.attachments.where(evidence: attachment_params[:evidence_id]).first
    @attachment = Attachment.create(attachment_params) unless @attachment
    @attachment.data.purge
    @attachment.data.attach(attachment_params[:data])
    @attachment.attachment_type = :evidence
    @attachment.save

    @application.attachments << @attachment
    @application.save
    redirect_to add_evidences_application_path(@application), notice: "แนบหลักฐาน #{@attachment.evidence.name} สำเร็จ"
  end

  def finish_add_evidences
    @application.submit_for_approve
    redirect_to process_dashboard_path, notice: "ได้ยืนยันการยื่นหลักฐานของใบสมัครหมายเลข #{@application.id} แล้ว"
  end


  def submit
    @application.submit_for_approve
    redirect_to process_dashboard_path, notice: 'Application is submitted'
  end

  def extend
    @apps = Application.finished
  end

  def extend_from
    app = Application.extend(@application)
    redirect_to apply_step1_application_path(app)
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application

      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:number, :user, :state, :licensee, :route, :category, :appointment_date, :appointment_remark, :appointment_user, :evaluation_finish_date, :award_date, :award, :award_remark, :contact, :contact_tel, :confirmed_date, :awarded_date,:evaluated_date, :submitted_date, :car_count, :trip_count, :license_no, :license_expire, :contact_email, :service_area)
    end

    def route_params
      params.require(:route).permit(:start, :destination, :route_no)
    end

    def licensee_params
      params.require(:licensee).permit(:name, :contact, :contact_tel)
    end

    def attachment_contract_signup_params
      params.require(:attachment).permit(:contract_data, :contract_file_name, :signup_data, :signup_file_name, :license_data, :license_file_name, :b11_data, :b11_file_name)
    end

    def attachment_params
      params.require(:attachment).permit(:evidence_id, :data, :filename)
    end

    def application_evaluation_params
      params.fetch(:result, {})
    end

end
