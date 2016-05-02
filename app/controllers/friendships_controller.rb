class FriendshipsController < ApplicationController
  def create
  end
  
  def update
    friendship = Friendship.find(params[:id])
    @user      = friendship.friender
    if params[:ignore]
      current_user.unfriend(@user)
    else
      friendship.accept
    end
    redirect_to :back
  end
end
