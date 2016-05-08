require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "comments must be attached to a user" do
    comment = posts(:remilia).comments.build()
    assert_not comment.valid?
  end
  
  test "comments must be attached to a post" do
    comment = users(:reimu).comments.build()
    assert_not comment.valid?
  end
  
  test "comments must have text" do
    comment = users(:reimu).comments.build(post_id: posts(:remilia).id)
    assert_not comment.valid?
  end
end
