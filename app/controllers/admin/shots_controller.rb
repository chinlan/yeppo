class Admin::ShotsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  def destroy
    @shot = Shot.find(params[:id])
    @shot.destroy
    redirect_to :back
  end
  
end
