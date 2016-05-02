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
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def destroy
    @user = Friendship.find(params[:id]).friender
    current_user.unfriend(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
