class UsersController < ApplicationController
  def index
    render :index, locals: { users: other_users }
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
      @current_relationship ||= requested_user.
                                follower_relationships.
                                find_by(subscriber: current_user)
    end
    
    def other_users
      @other_users ||= User.all - [current_user]
    end
end
