class WelcomeController < ApplicationController

  def index 
    load_shots
  end

  def photographers
    load_shots("photographer")
    
    render "index"
  end

  def models
    load_shots("model")

    render "index"
  end

  protected

  def load_shots(shot_type=nil)

    @shots = Shot.includes(:user).publicing

    if shot_type == 'photographer'
      @shots = @shots.only_photographer
    elsif shot_type == 'model'
      @shots = @shots.only_model      
    end

    if params[:tag]
      @shots = @shots.tagged_with(params[:tag])
    end
    
    @search = @shots.ransack(params[:q])
    @shots = @search.result(distinct: true)
   
  end

end
