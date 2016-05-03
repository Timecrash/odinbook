require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:reimu)
    @post = @user.posts.build(text: "Hello, world!")
  end
  
  test "posts shouldn't be empty" do
    @post.text = "   "
    assert_not @post.valid?
  end
  
  test "posts should have an author" do
    authorless_post = Post.new(text: "Doesn't matter.")
    assert_not authorless_post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end
