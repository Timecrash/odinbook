require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test "likes must be attached to a user" do
    like = posts(:remilia).likes.build()
    assert_not like.valid?
  end
  
  test "likes must be attached to a post" do
    like = users(:reimu).likes.build()
    assert_not like.valid?
  end
  
  test "likes should display correct count" do
    assert_equal posts(:remilia).likes.count, 3
  end
end
