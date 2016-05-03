class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def friends
    @user = User.find(params[:id])
  end
end
