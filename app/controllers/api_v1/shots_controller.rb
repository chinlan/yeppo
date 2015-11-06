class ApiV1::ShotsController < ApiController

  before_action :authenticate_user!
  
  
  def index
    @shots = Shot.all  
  end
  
  def show
    @shot = Shot.find(params[:id])
    # render json: @shot
  end

  def create
       @shot = current_user.shots.new(shot_params)
       if @shot.save
          render :json => { :message => "Successfully created", :id => @shot.id }
       else
          render :json => { :message => "Validate failed" }, :status => 400
       end
  end

  def update
       @shot = current_user.shots.find(params[:id])
       if @shot.update
          render :json => { :message => "Successfully updated", :id => @shot.id}
       else 
          render :json => { :message => "Validate failed" }, :status => 400
       end
  end

  def destroy
       @shot = current_user.shots.find(params[:id])
       @shot.destroy
       render :json => { :message => "Successfully deleted", :id => @shot.id}
  end

  private

  def shot_params
    params.permit(:description,:photo,:tag_list, :shot_type, :tag_user_id, :tag_category)
  end


end
