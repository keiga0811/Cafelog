class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = PostImage.where(user_id: @user.id).page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def following
    @user = User.find(params[:user_id])
    @users = User.all
    @follow = @user.followings
  end

  def followers
    @users = User.all
    @user = User.find(params[:user_id])
    @follow = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
