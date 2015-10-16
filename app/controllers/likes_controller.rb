class LikesController < ApplicationController

  before_action :set_user, :set_shot

  def create

    @like = @shot.likes.new
    @like.user = current_user
    @like.save
  end

  def destroy
    @like = @shot.likes.find(params[:id])
    @like.destroy!
    @like = nil
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shot
    @shot = @user.shots.find(params[:shot_id])
  end

end
