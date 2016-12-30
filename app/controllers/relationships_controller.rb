class RelationshipsController < ApplicationController
  def create
    if new_relationship.save
      redirect_to user_url(requested_user), notice: "Relationship created."
    else
      render :new, locals: { relationship: new_relationship }
    end
  end
  
  def destroy
    requested_user.follower_relationships.destroy(requested_relationship)
    redirect_to user_url(requested_user), notice: "Relationship destroyed."
  end
  
  private
    def requested_user
      @user ||= User.find(params[:user_id])
    end
    
    def requested_relationship
      @relationship ||= requested_user.follower_relationships.find(params[:id])
    end
    
    def new_relationship
      @relationship ||= Relationship.new(new_relationship_params)
    end
    
    def new_relationship_params
      { subscriber: current_user,
        publisher: requested_user }
    end
end
