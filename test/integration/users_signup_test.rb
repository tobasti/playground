require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                        email: "invalid@user.",
                                        password:              "00000000",
                                        password_confirmation: "XXXXXXXX" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'form[action="/signup"]'
  end

  test "valid user signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Claudia",
                                        email: "claudia@123.de",
                                        password:              "12345678",
                                        password_confirmation: "12345678" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
