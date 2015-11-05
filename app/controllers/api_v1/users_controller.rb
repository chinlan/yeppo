class ApiV1::UsersController < ApiController

  before_action :authenticate_user!

  def index
     @users = User.publicing.includes(:shots => :comments).order("id DESC").all
  end

  def show
    @user = User.find(params[:id])
    # render json: @user # FIXME
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
