class UsersController < ApplicationController

  #before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @shots = Shot.all
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

  private

  def user_params
    params.require(:user).permit(:username,:name,:location,:content, :head)
  end

end
