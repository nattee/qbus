class ApplicationController < ActionController::Base
  #THIS IS THE BASE CLASE
  #  NOT THE RESOURCE "Applications"
  #
  #  My fault... should not name the resource as "applications"

  before_action :set_locale

  def set_locale
    I18n.locale = I18n.default_locale
  end

  protect_from_forgery with: :exception

  include SessionsHelper

  def logged_in_user
    unless logged_in?
      redirect_to login_url, flash: {error: 'ท่านต้องเข้าสู่ระบบก่อน'}
    end
  end

  def admin_authorization
    unless @current_user &&  @current_user.is_admin?
      redirect_to root_path, flash: {error: 'ท่านไม่มีสิทธิ์ในการทำรายการดังกล่าว'}
    end
  end

end
