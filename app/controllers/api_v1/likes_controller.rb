class ApiV1::LikesController < ApiController

  before_action :authenticate_user!
  before_action :set_user, :set_shot

  def create
       @like = @shot.likes.new
       if @like.save
         render :json => { :message => "Successfully created", :id => @like.id }
       else
         render :json => { :message => "Validate failed" }, :status => 400
       end
  end

  def destroy
       @like = @shot.likes.find(params[:id])
       @like.destroy
       render :json => { :message => "Successfully deleted", :id => @like.id}
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shot
    @shot = @user.shots.find(params[:shot_id])
  end
end
