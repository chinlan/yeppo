class ShotCommentsController < ApplicationController

  before_action :set_user,:set_shot

  def create
    @comment = @shot.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
       
      respond_to do |format|
        format.html{ redirect_to user_shot_path(@user, @shot) }
        format.js
      end
    else
      redirect_to user_shot_path(@user,@shot)
    end
  end

  def destroy
    # TODO: allow shot owner can delete comment too
    @comment = current_user.comments.find(params[:id])
   
    @comment.destroy
    
    respond_to do |format|
      format.html {redirect_to user_shot_path(@user,@shot)}
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shot
    @shot = @user.shots.find(params[:shot_id])
  end

end
