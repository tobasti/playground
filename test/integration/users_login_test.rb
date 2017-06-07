require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_dummy)
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'kennword' } }
    assert_redirected_to @user, "not properly redirected)"
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with invalid information" do
    get login_path
    is_login?
    post login_path, params: { session: {email: "", password: "" } }
    is_login?
    assert_not flash.empty?, "flash should not be empty after re-render"
    get root_path
    assert flash.empty?, "flash should be empty on the following page"
  end

  private
    def is_login?
      assert_select 'title', /Log In/
      assert_select 'input[type=text]', 1
      assert_select 'input[type=password]', 1
    end
end
