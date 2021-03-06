class ShotsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_user

  def new
    @dark = true
    @shot = Shot.new
  end

  def create
    @shot = Shot.new(shot_params)
    @shot.user = current_user

    if @shot.save
      redirect_to user_path(@user)
     else
      flash[:alert] = "作品類型和照片為必填欄位喔"
      render 'new'
    end
  end

  def show
    @shot = @user.shots.find(params[:id])

    unless cookies["visit-shot-#{@shot.id}"]
      cookies["visit-shot-#{@shot.id}"] = "Ya"
      @shot.views_count += 1
      @shot.save!
    end

    @comment = Comment.new
    @comments = @shot.comments.includes(:user).all

    if current_user
      @like = current_user.likes.find_by(:shot => @shot)
    end
  end

  def edit
    @dark = true
    @shot = @user.shots.find(params[:id])
  end

  def update
    @shot = @user.shots.find(params[:id])
    if @shot.update(shot_params)
       @user.save
       redirect_to user_path(@user)
     else
       render 'edit'
    end
  end

  def destroy
    @shot = @user.shots.find(params[:id])
    @shot.destroy
    redirect_to :back
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def shot_params
    params.require(:shot).permit(:description, :photo, :tag_list, :shot_type, :tag_user_id, :tag_category)
  end
end
