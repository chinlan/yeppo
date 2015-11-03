class ApiV1::LikesController < ApiController
  before_action :set_user, :set_shot

  def create
    if authenticate_user_from_token!
       @like = @shot.likes.new
       if @like.save
         render :json => { :message => "Successfully created", :id => @like.id }
       else
         render :json => { :message => "Validate failed" }, :status => 400
       end
    else
      render :json => {:message => "auth_token failed"}, :status => 400
    end
  end

  def destroy
    if authenticate_user_from_token!
       @like = @shot.likes.find(params[:id])
       @like.destroy
       render :json => { :message => "Successfully deleted", :id => @like.id}
    else
       render :json => { :message => "auth_token failed"}, :status => 400
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shot
    @shot = @user.shots.find(params[:shot_id])
  end
end
