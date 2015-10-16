class WelcomeController < ApplicationController

  def index 
    @users = User.all
    @shots = Shot.all

    if params[:tag]
      @shots = @shots.tagged_with(params[:tag])
    else
      @shots = @shots.all
    end

  end
end
