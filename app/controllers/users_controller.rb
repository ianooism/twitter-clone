class UsersController < ApplicationController
  def index
    render :index, locals: { users: User.all }
  end
  
  def show
    render :show, locals: { user: requested_user,
                            posts: requested_user.posts,
                            relationship: current_relationship }
  end
  
  private
    def requested_user
      @user ||= User.find(params[:id])
    end
    
    def current_relationship
      requested_user.follower_relationships.find_by(subscriber: current_user)
    end
end
