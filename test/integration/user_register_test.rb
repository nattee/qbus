require 'test_helper'

class UserRegisterTest < ActionDispatch::IntegrationTest
  test "invalid register information" do
    get register_path
    assert_no_difference 'User.count' do
      post register_path, params: { user: {
        name: "not invalid user",
        email: "user@invalid",
        tel: "not invalid tel",
        password: "foo",
        password_confirmation: "bar"
      } }
    end
    assert_template 'sessions/register'
  end
  test "valid register information" do
    get register_path
    assert_difference 'User.count', 1 do
      post register_path, params: { user: {
        name: "valid user",
        email: "userregister@example.com",
        tel: "valid tel",
        password: "password",
        password_confirmation: "password"
      } }
    end
    assert_redirected_to root_url
  end
end
