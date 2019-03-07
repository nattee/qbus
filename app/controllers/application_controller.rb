class ApplicationController < ActionController::Base
  #THIS IS THE BASE CLASE
  #  NOT THE RESOURCE "Applications"
  #
  #  My fault... should not name the resource as "applications"

  before_action :set_locale

  before_action :force_login

  def set_locale
    I18n.locale = I18n.default_locale
  end

  protect_from_forgery with: :exception
  include SessionsHelper

  def force_login
    log_in(User.first)
  end
end
