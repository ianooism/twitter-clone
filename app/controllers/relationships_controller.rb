class RelationshipsController < ApplicationController
  # POST /relationships/:user_id
  def create
    current_user.follow(requested_user)
    redirect_to user_url(requested_user), notice: "Relationship created."
  end
  
  # DELETE /relationships/:user_id
  def destroy
    current_user.unfollow(requested_user)
    redirect_to user_url(requested_user), notice: "Relationship destroyed."
  end
  
  private
    def requested_user
      @user ||= User.find(params[:user_id])
    end
end
