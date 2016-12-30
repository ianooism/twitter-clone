class UsersController < ApplicationController
  def index
    render :index, locals: { users: current_user.not_following }
  end
  
  def show
    render :show, locals: { user: requested_user,
                            posts: requested_user.posts,
                            followers: requested_user.followers,
                            following: requested_user.following,
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
