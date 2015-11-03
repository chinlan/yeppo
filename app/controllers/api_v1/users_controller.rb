class ApiV1::UsersController < ApiController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    render json: @user
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
