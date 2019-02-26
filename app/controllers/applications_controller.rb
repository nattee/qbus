class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy, 
                                         :apply_step1, :apply_step2, :apply_step3,
                                         :post_step1,:post_step2,:post_step3,
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
    @route = Route.new(start: params[:route][:start], destination: params[:route][:destination])
    @route.save
    @application.route = @route
    if @application.save
      redirect_to apply_step2_application_path(@application) , notice: 'aa'
    else
      redirect_to apply_applications_path
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
    if @application.save
      redirect_to dashboard_application_path(@application) , notice: 'สร้างใบสมัครเรียบร้อย'
    else
      redirect_to apply_applications_path
    end

  end

  def add_car
    car = Car.new(plate: params[:plate], chassis: params[:chassis])
    @application.route.cars << car
    redirect_to apply_step2_application_path(@application)
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
      params.require(:application).permit(:number, :user, :state, :licensee, :route, :category, :appointment_date, :appointment_remark, :appointment_user, :evaluation_finish_date, :award_date, :award, :award_remark, :contact, :contact_tel)
    end

end
