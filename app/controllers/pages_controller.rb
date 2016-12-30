class PagesController < ApplicationController
  before_action :authenticate_user!, only: :home
  
  def home
    render :home, locals: { posts: current_user.home_posts }
  end
end
