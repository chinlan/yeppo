class ApiV1::CommentsController < ApiController
  
  before_filter :set_user, :set_shot

  def create
    if authenticate_user_from_token!
       @comment = @shot.comments.new(comment_params)
       if @shot.save
         render :json => { :message => "Successfully created", :id => @comment.id }
       else
         render :json => { :message => "Validate failed" }, :status => 400
       end
    else 
       render :json => { :message => "auth_token failed" }, :status => 400
    end
  end

  def destroy
    if authenticate_user_from_token!
       @comment = @shot.comments.find(params[:id])
       @comment.destroy
       render :json => { :message => "Successfully deleted", :id => @comment.id}
    else
      render :json => {:message => "auth_token failed"}, :status => 400
    end
  end

  private

  def comment_params
    params.permit(:content)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shot
    @shot = @user.shots.find(params[:shot_id])
  end
end
