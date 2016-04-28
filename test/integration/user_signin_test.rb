require 'test_helper'

class UserSigninTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:reimu)
  end
  
  test 'must log in to see any other page' do
    get user_path(@user)
    assert_redirected_to new_user_session_path
    
    get users_path
    assert_redirected_to new_user_session_path
  end
end
