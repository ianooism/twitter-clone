class UsersController < ApplicationController
  def index
    render :index, locals: { users: User.all }
  end
  
  def show
    render :show, locals: { user: requested_user,
                            posts: requested_user.posts,
                            following: current_user.following }
  end
  
  private
    def requested_user
      @user ||= User.find(params[:id])
    end
end
