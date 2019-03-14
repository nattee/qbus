class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy,
                                         :apply_step1, :apply_step2, :apply_step3,
                                         :post_step1,:post_step2,:post_step3,
                                         :add_evidences,:add_attachment,
                                         :add_car
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

  end

  def post_apply
    @application = Application.new(application_params)

    if @application.save
      redirect_to apply_step1_application_path(@application) , notice: 'aa'
    else
      redirect_to apply_applications_path
    end
  end

  def post_step1
    #routes and licensee data
    @application.update(application_params)
    unless @application.category3?
      @route = Route.new(route_params)
      @route.save
      @application.route = @route
    end

    @licensee = Licensee.new(licensee_params)
    @application.licensee = @licensee
    if @application.save
      redirect_to apply_step2_application_path(@application) , notice: 'aa'
    else
      redirect_to apply_applications_path
    end

    if !@application.attach_contract_data(attachment_contract_signup_params)
      redirect_to apply_step1_applications_path(@application), notice: 'failed to attach contract data'
    end
    if !@application.attach_signup_data(attachment_contract_signup_params)
      redirect_to apply_step1_applications_path(@application), notice: 'failed to attach signup data'
    end

  end

  def post_step2
    #car data

    if @application.save
      redirect_to apply_step3_application_path(@application) , notice: 'aa'
    else
      redirect_to apply_applications_path
    end
  end

  def post_step3
    @application.state = :registered
    if @application.save
      redirect_to process_dashboard_path , notice: 'สร้างใบสมัครเรียบร้อย'
    else
      redirect_to apply_applications_path
    end

  end

  def add_car
    car = Car.new(plate: params[:plate], chassis: params[:chassis])
    @application.route.cars << car
    redirect_to apply_step2_application_path(@application)
  end

  #attachment index
  def add_evidences
    @application.add_missing_attachments
    @attachment = Attachment.new
  end

  #post
  def add_attachment
    @attachment = Attachment.create(attachment_params)
    @attachment.data.attach(attachment_params[:data])
    @attachment.save
    @application.attachments << @attachment
    @application.save
    redirect_to add_evidences_application_path(@application), notice: 'Attachment is submitted'
  end


  def submit
    @application.submit_for_approve
    redirect_to process_dashboard_path, notice: 'Application is submitted'
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
      params.require(:application).permit(:number, :user, :state, :licensee, :route, :category, :appointment_date, :appointment_remark, :appointment_user, :evaluation_finish_date, :award_date, :award, :award_remark, :contact, :contact_tel, :confirmed_date, :awarded_date,:evaluated_date, :submitted_date, :car_count, :trip_count)
    end

    def route_params
      params.require(:route).permit(:start, :destination)
    end

    def licensee_params
      params.require(:licensee).permit(:name, :contact, :contact_tel)
    end

    def attachment_contract_signup_params
      params.require(:attachment).permit(:contract_data, :contract_file_name, :signup_data, :signup_file_name)
    end

    def attachment_params
      params.require(:attachment).permit(:criterium_attachment_id, :data)
    end

end
