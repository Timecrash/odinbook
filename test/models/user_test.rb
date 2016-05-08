require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "Yuyuko", last_name: "Saigyouji", email: "yuyuko@gensokyo.net",
                     password: 'password', password_confirmation: 'password')
  end
  
  test "first and last names should be present" do
    @user.first_name = nil
    assert_not @user.valid?
    @user.first_name = "Yuyuko"
    @user.last_name = nil
    assert_not @user.valid?
  end
  
  test "name method should return full name" do
    assert_equal @user.name, "Yuyuko Saigyouji"
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
    assert_not reimu.friends?(reisen)
    assert_not reisen.friends?(reimu)
    #Reimu initiates, but Reisen hasn't accepted.
    reimu.friend(reisen)
    assert_not reimu.friends?(reisen)
    assert_not reisen.friends?(reimu)
    #Reisen accepts, they're now friends in the FB sense.
    reisen.accept_friendship(reimu)
    assert reimu.friends?(reisen)
    assert reisen.friends?(reimu)
  end
  
  test "should unfriend a user" do
    reimu  = users(:reimu)
    marisa = users(:marisa)
    sanae  = users(:sanae)
    assert reimu.friends?(marisa) #Reimu friended Marisa, so it's active.
    reimu.unfriend(marisa)
    assert_not reimu.friends?(marisa)
    assert reimu.friends?(sanae) #Sanae friended Reimu, so it's passive.
    reimu.unfriend(sanae)
    assert_not reimu.friends?(sanae)
  end
  
  test "friend confirmation" do
    marisa = users(:marisa)
    reisen = users(:reisen)
    assert_equal marisa.friends.count, 2
    assert_equal reisen.friend_requests.count, 1
    reisen.accept_friendship(marisa)
    assert_equal marisa.friends.count, 3
    assert_equal reisen.friend_requests.count, 0
  end
  
  test "authored post should be destroyed upon user deletion" do
    @user.save!
    @user.posts.create!(text: "asdf")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end
  
  test "timeline should return a user's and their friends' posts" do
    reimu  = users(:reimu)
    marisa = users(:marisa)
    reisen = users(:reisen)
    #Posts from friend
    marisa.posts.each do |post_friend|
      assert reimu.timeline.include?(post_friend)
    end
    #Posts from self
    reimu.posts.each do |post_self|
      assert reimu.timeline.include?(post_self)
    end
    #Posts from unfriended user
    reisen.posts.each do |post_nonfriend|
      assert_not reimu.timeline.include?(post_nonfriend)
    end
  end
  
  test "pending_friend should return any pending friend requests" do
    reisen = users(:reisen)
    marisa = users(:marisa)
    assert_not reisen.pending_friend(marisa).nil?
  end
end
