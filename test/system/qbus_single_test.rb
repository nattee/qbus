require "application_system_test_case"

class QbusTest < ApplicationSystemTestCase
  setup do
    Rails.application.load_seed
    @user_admin = User.find(1)
    @user_offical = User.find(2)
    @user_licensee = User.find(3)
  end

end
