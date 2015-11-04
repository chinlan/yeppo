class ApiV1::UsersController < ApiController

  def index
    if authenticate_user_from_token!
       @users = User.all
    else
      render :json => {:message => "auth_token failed"}, :status => 400
    end
  end

  def show
    if authenticate_user_from_token!
      @user = User.find(params[:id])
      render json: @user
    else
      render :json => { :message => "auth_token failed"}, :status => 400
    end
  end


  def update
    if authenticate_user_from_token!
       @user = User.find(params[:id])
       if @user.update(user_params)
          render :json => { :message => "Successfully updated", :id => @user.id }
       else
          render :json => { :message => "Validate failed" }, :status => 400
       end
    else
      render :json => { :message => "auth_token failed"}, :status => 400
    end
  end

end
