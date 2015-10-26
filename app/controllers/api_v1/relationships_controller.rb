class ApiV1::RelationshipsController < ApiController

  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow!(@user)
    render :json => { :message => "Success", :id => :followed_id}
    
  end

  def destroy
    @user = User.find(params[:followed_id])    
    current_user.unfollow!(@user)
    render :json => { :message => "Successfully deleted", :id => :followed_id }
  end

end

