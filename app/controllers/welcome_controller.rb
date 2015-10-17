class WelcomeController < ApplicationController

  def index 
    @users = User.all
    @shots = Shot.all
    @user = current_user

    if params[:tag]
      @shots = @shots.tagged_with(params[:tag])
    else
      @shots = @shots.all
    end

  end

  private

  def publicing?
    @user.public? == true
  end
       
end
