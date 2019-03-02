class ApplicationController < ActionController::Base
  #THIS IS THE BASE CLASE
  #  NOT THE RESOURCE "Applications"
  #
  #  My fault... should not name the resource as "applications"

  before_action :set_locale

  def set_locale
    I18n.locale = I18n.default_locale
  end
end
