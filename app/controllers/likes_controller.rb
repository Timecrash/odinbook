class LikesController < ApplicationController
  def create
    like = current_user.likes.build(post_id: params[:post_id])
    if like.save
      redirect_to :back
    else
      flash[:error] = "Something went wrong!"
    end
  end
  
  def destroy
    Like.find(params[:id]).destroy
    redirect_to :back
  end
end
