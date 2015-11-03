class ApiV1::RelationshipsController < ApiController

  before_action :authenticate_user!

  def create
    if authenticate_user_form_token!
       @user = User.find(params[:followed_id])
       current_user.follow!(@user)
       render :json => { :message => "Success", :id => :followed_id}
    else
      render :json => {:message => "auth_token failed"}, :status => 400
    end
    
  end

  def destroy
    if authenticate_user_form_token!
       @user = User.find(params[:followed_id])    
       current_user.unfollow!(@user)
       render :json => { :message => "Successfully deleted", :id => :followed_id }
    else 
      render :json => {:message => "auth_token failed"}, :status => 400
    end
  end

end

