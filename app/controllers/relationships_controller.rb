class RelationshipsController < ApplicationController
  # user can be followed (subscribe) and un-followed (un-subscribe)
  def create
    if new_relationship.update(relationship_form_params)
      redirect_to user_url(requested_user), notice: "Relationship created."
    else
      render :new, locals: { relationship: new_relationship }
    end
  end
  
  def destroy
    requested_user.publisher_relationships.destroy(current_relationship)
    redirect_to user_url(requested_user), notice: "Relationship destroyed."
  end
  
  private
    def requested_user
      @user ||= User.find(params[:user_id])
    end
    
    def current_relationship
      @relationship ||= requested_user.publisher_relationships.find(params[:id])
    end
    
    def new_relationship
      @relationship ||= Relationship.new(new_relationship_params)
    end
    
    def new_relationship_params
      { subscriber: current_user,
        publisher: requested_user }
    end
    
    def relationship_form_params
      {}
    end
end
