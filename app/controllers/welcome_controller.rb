class WelcomeController < ApplicationController

  def index 
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @shots = @category.shots.publicing
    else
      @shots = Shot.publicing
    end

    if params[:tag]
      @shots = @shots.tagged_with(params[:tag])
    else
      @shots = @shots.all
    end
    
    @search = @shots.ransack(params[:q])
    @shots = @search.result(distinct: true)
   
  end

  
       
end
