class UsersController < ApplicationController

  #before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @shots = @user.shots.page(params[:page]).per(6)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
        redirect_to :back
    else
      render 'edit'
    end
  end

  def following
    @title = "我追蹤的人"
    @user = User.find(params[:id])
    @users = @user.followed_users
   
  end

  def followers
    @title = "追蹤我的人"
    @user = User.find(params[:id])
    @users = @user.followers
    
  end

  private

  def user_params
    params.require(:user).permit(:friendly_id,:name,:location,:content, :head, :status)
  end


end
