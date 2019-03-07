require 'test_helper'

class UserRegisterTest < ActionDispatch::IntegrationTest
  test "invalid register information" do
    get register_path
    assert_no_difference 'User.count' do
      post register_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'sessions/register'
  end
  test "valid register information" do
    get register_path
    assert_difference 'User.count', 1 do
      post register_path, params: { user: {
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_redirected_to root_url
    assert is_logged_in?
  end
end
