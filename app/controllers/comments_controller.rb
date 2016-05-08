class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(post_id: params[:post_id], comment_params)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
