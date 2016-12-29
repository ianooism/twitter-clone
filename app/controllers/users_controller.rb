class UsersController < ApplicationController
  def show
    render :show, local: { user: requested_user }
  end
  
  private
    def requested_user
      @user ||= User.find(params[:id])
    end
end
