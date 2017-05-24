require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Anton', email: 'Anton.Berger@Circus.de', password: 'kennwort', password_confirmation: 'kennwort')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51 
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.org"
    assert_not @user.valid?
  end

  test "email validation should accept valid email addresses" do
    valid_addresses = %w[ser@example.com      USER@foo.COM
                         A_US-ER@foo.bar.org  first.last@foo.jp
                         alice+bob@baz.cn] 
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com   user_at_foo.org 
                           user.name@example. foo@bar_baz.com
                           foo@bar+baz.com    foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.swapcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "emails should be saved to lowercase" do
    mixed_case_example = "Foo@ExamPLe.OrG"
    @user.email = mixed_case_example
    @user.save
    assert_equal mixed_case_example.downcase, @user.reload.email
  end

  test "password should be present and not blank" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end
  
  test "password should be at least 8 characters long" do
    @user.password = @user.password_confirmation = "c" * 7
    assert_not @user.valid?
  end
end
