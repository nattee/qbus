class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to root_url, notice: "เปิดการใช้งานเรียบร้อย ยินดีต้อนรับเข้าสู่ระบบ"
    else
      redirect_to root_url, notice: "Invalid activation link"
    end
  end
end
