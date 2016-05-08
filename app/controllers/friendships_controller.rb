class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user])
    current_user.friend(user)
    redirect_to :back || user
  end

  def update
    friendship = Friendship.find(params[:id])
    user       = friendship.friender
    if params[:ignore]
      flash[:notice] = "You've ignored #{user.first_name}'s friend request."
      current_user.unfriend(user)
    else
      flash[:success] = "You are now friends with #{user.name}!"
      friendship.accept
    end
    redirect_to :back || user
  end

  def destroy
    friendship = Friendship.find(params[:id])
    user = friendship.friender == current_user ? friendship.friended : friendship.friender
    current_user.unfriend(user)
    flash[:success] = "User unfriended."
    redirect_to :back || user
  end
end
