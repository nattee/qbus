class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :update_profile, :edit_profile]

  before_action :logged_in_user
  before_action :owner_authorization, only: [:update_profile, :edit_profile]
  before_action :admin_authorization, only: [:destroy, :edit, :update, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /users/1/edit
  def edit_profile
    @as_profile = true
    render :edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'สร้างผู้ใช้ใหม่เรียบร้อย' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      @user.roles.clear
      if @user.update(user_params)
        format.html { redirect_to target, notice: 'แก้ไขข้อมูลผู้ใช้เรียบร้อย' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_profile
    respond_to do |format|
      if @user.update(user_profile_params)
        format.html { redirect_to profile_path, notice: 'แก้ไขข้อมูลผู้ใช้เรียบร้อย' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :activated, :password, :password_confirmation, :admin, :verifier, :surveyor, :evaluator, :committee, :licensee, :tel)
    end

    def user_profile_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :tel)
    end

    def owner_authorization
      unless @current_user.id == @user.id
        redirect_to root_path, flash: {error: 'ท่านไม่มีสิทธิ์ในการทำรายการดังกล่าว'}
      end
    end
end
