class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_user, :only => [:edit, :update,:destroy]

  layout "admin"

  def index
    @users = User.all
    @user = current_user
    @shots = Shot.all
  end

  def edit
    
  end

  def update
    
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
   @user.destroy
   redirect_to :back
  end

  def bulk_update
    ids = Array(params[:ids])
    users = ids.map{ |u| User.find_by_id(u)}.compact

    if params[:commit] == "admin"
      users.each{ |u| u.update(:role => "admin")}
    else
      user.each { |u| u.update(:role => "normal")}
    end

    redirect_to admin_forums_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end 

end
