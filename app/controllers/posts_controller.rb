class PostsController < ApplicationController
  #Gets the user's feed, instead of all posts.
  def index
  end
  
  def show
    @post = Post.find(params[:id])
  end
end
