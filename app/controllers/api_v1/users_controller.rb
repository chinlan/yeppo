class ApiV1::UsersController < ApiController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render :json => { :message => "Successfully updated", :id => @user.id }
    else
      render :json => { :message => "Validate failed" }, :status => 400
    end
  end

end
