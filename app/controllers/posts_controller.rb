class PostsController < ApplicationController
  before_action :correct_user, only: [:update, :destroy]
  
  #Gets the user's feed, instead of all posts.
  def index
    #@posts = current_user.timeline
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to request.referrer || root_url
    else
      render root_url
    end
  end
  
  def update
    if @post.update(post_params)
      flash.now[:success] = "Post updated!"
      #respond_to do |format|
      #  format.html { redirect_to request.referrer || root_url }
      #  format.js
      #end
      redirect_to request.referrer || @post
    else
      flash.now[:error] = "Invalid information."
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted!"
    redirect_to request.referrer || root_url
  end
  
  private
  def post_params
    params.require(:post).permit(:text)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
