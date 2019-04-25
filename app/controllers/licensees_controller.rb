class LicenseesController < ApplicationController
  before_action :set_licensee, only: [:show, :edit, :update, :destroy]
  before_action :admin_authorization

  # GET /licensees
  # GET /licensees.json
  def index
    @licensees = Licensee.all
  end

  # GET /licensees/1
  # GET /licensees/1.json
  def show
  end

  # GET /licensees/new
  def new
    @licensee = Licensee.new
  end

  # GET /licensees/1/edit
  def edit
  end

  # POST /licensees
  # POST /licensees.json
  def create
    puts licensee_params
    @licensee = Licensee.new(licensee_params)

    respond_to do |format|
      if @licensee.save
        format.html { redirect_to @licensee, notice: 'Licensee was successfully created.' }
        format.json { render :show, status: :created, location: @licensee }
      else
        format.html { render :new }
        format.json { render json: @licensee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licensees/1
  # PATCH/PUT /licensees/1.json
  def update
    respond_to do |format|
      if @licensee.update(licensee_params)
        format.html { redirect_to @licensee, notice: 'Licensee was successfully updated.' }
        format.json { render :show, status: :ok, location: @licensee }
      else
        format.html { render :edit }
        format.json { render json: @licensee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licensees/1
  # DELETE /licensees/1.json
  def destroy
    @licensee.destroy
    respond_to do |format|
      format.html { redirect_to licensees_url, notice: 'Licensee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licensee
      @licensee = Licensee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def licensee_params
      params.require(:licensee).permit(:name, :license_no, :license_expire, :car_count, :contact, :contact_tel)
    end
end
