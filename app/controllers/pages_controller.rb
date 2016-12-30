class PagesController < ApplicationController
  before_action :authenticate_user!, only: :home
  
  def home
    render :home, locals: { posts: feed_posts }
  end
  
  private
    def feed_posts
      current_user.following_posts + current_user.posts
    end
end
