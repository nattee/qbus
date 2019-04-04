class SessionsController < ApplicationController

  # GET /register
  def register
    @user = User.new
  end

  # POST /register
  def register_post
    register_params = params.require(:user).permit(:email, :password, :password_confirmation)
    @user = User.new(register_params)
    @user.name = @user.email

    respond_to do |format|
      if @user.save
        @user.send_activation_email
        # TODO: remove those two line when sending email is working properly
        @user.activate
        log_in @user
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
        redirect_to process_dashboard_path, notice: 'เข้า่สู่ระบบเรียบร้อย'
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        redirect_to root_url, notice: message
      end
    else
      redirect_to login_url, notice: 'invalid username or password'
    end
  end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
