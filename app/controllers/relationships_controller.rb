class RelationshipsController < ApplicationController
  # user can follow (subscribe) and un-follow (un-subscribe)
  def create
    if new_relationship.update(relationship_form_params)
      redirect_to root_url, notice: "Relationship created."
    else
      render :new, locals: { relationship: new_relationship }
    end
  end
  
  private
    def requested_user
      @user ||= User.find(params[:user_id])
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
