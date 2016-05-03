require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "Reimu", last_name: "Hakurei", email: "reimu@gensokyo.net",
                       password: 'password', password_confirmation: 'password')
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
end
