class CommentsController < ApplicationController
  before_action :correct_user, only: [:update, :destroy]
  
  def create
    @post    = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to :back
    else
      flash[:error] = "Something went wrong!"
      redirect_to :back
    end
  end
  
  def update
    if @comment.update(comment_params)
      flash[:success] = "Comment updated!"
      redirect_to :back || @comment.post
    else
      flash.now[:error] = "Invalid information."
    end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted!"
    redirect_to :back || root_url
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:text)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
