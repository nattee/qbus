class ApplicationController < ActionController::Base
  #THIS IS THE BASE CLASE
  #  NOT THE RESOURCE "Applications"
  #
  #  My fault... should not name the resource as "applications"

  before_action :set_locale

  before_action :current_user

  def set_locale
    I18n.locale = I18n.default_locale
  end

  protect_from_forgery with: :exception

  include SessionsHelper

  def logged_in_user
    unless logged_in?
      redirect_to login_url, flash: {error: 'ท่านต้องเข้าสู่ระบบก่อนกระทำรายการดังกล่าว'}
    end
  end

  def admin_authorization
    unless @current_user &&  @current_user.is_admin?
      redirect_to root_path, flash: {error: 'ท่านไม่มีสิทธิ์ในการทำรายการดังกล่าว'}
    end
  end

  def has_licensee_role
    unless logged_in? && @current_user.has_role(:licensee)
      redirect_to root_path, flash: {error: 'ท่านไม่มีสิทธิ์ในการทำรายการดังกล่าว'}
    end
  end

  def logged_in_with_role(roles =[])
    unless logged_in?
      redirect_to login_url, flash: {error: 'ท่านต้องเข้าสู่ระบบก่อนกระทำรายการดังกล่าว'}
      return
    end

    pass = false
    roles.each do |role|
      if @current_user.has_role(role)
        pass=true
        break
      end
    end

    unless pass
      redirect_to root_path, flash: {error: 'ท่านไม่มีสิทธิ์ในการทำรายการดังกล่าว'}
    end
  end

  def owner_or_admin
    unless logged_in? && (@current_user.is_admin? || @current_user == @application.user)
      puts @current_user.is_admin?
      redirect_to root_path, flash: {error: 'ท่านไม่มีสิทธิ์ในการทำรายการดังกล่าว'}
    end
  end

end
