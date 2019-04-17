class SessionsController < ApplicationController

  # GET /register
  def register
    @user = User.new
  end

  # POST /register
  def register_post
    register_params = params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation)
    @user = User.new(register_params)
    @user.licensee = 1

    respond_to do |format|
      if @user.save
        @user.send_activation_email
        format.html { redirect_to root_url, notice: 'ลงทะเบียนเรียบร้อย' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :register }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /profile
  def profile
    if logged_in?
      render 'users/profile'
    else
      redirect_to root_url
    end
  end

  # GET /login
  def new
  end

  # POST /login
  def create
    session_params = params.require(:session).permit(:email, :password, :remember_me)
    user = User.find_by(email: session_params[:email].downcase)

    if user && user.authenticate(session_params[:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_url, notice: 'เข้าสู่ระบบเรียบร้อย'
      else
        message  = "ท่านยังไม่ได้ยืนยันอีเมล์ที่ใช้ในการลงทะเบียน "
        message += "กรุณาตรวจสอบอีเมล์องท่านเพื่อทำการยืนยันอีเมล์"
        flash[:error] = message
        redirect_to root_url
      end
    else
      redirect_to login_url, notice: 'อีเมล์หรือรหัสผ่านไม่ถูกต้อง'
    end
  end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
