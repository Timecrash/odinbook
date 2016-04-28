require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Reimu Hakurei", email: "reimu@gensokyo.net",
                     password: 'password', password_confirmation: 'password')
  end
  
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "e-mail should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "e-mail validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid."
    end
  end
  
  test "e-mail validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "uSeR@ExAmPlE.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "friends method returns both passive and active friends" do
    reimu = users(:reimu)
    assert_equal reimu.friends.count, 3
  end
  
  test "should friend a user" do
    reimu  = users(:reimu)
    reisen = users(:reisen)
    assert_not reimu.active_friends.include?(reisen)
    reimu.friend(reisen)
    assert reimu.active_friends.include?(reisen)
    assert reisen.passive_friends.include?(reimu)
  end
  
  test "should unfriend a user" do
    reimu  = users(:reimu)
    marisa = users(:marisa)
    sanae  = users(:sanae)
    assert reimu.active_friends.include?(marisa)
    reimu.unfriend(marisa)
    assert_not reimu.active_friends.include?(marisa)
    assert reimu.passive_friends.include?(sanae)
    reimu.unfriend(sanae)
    assert_not reimu.passive_friends.include?(sanae)
  end
end
