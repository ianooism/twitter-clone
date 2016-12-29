class PagesController < ApplicationController
  def home
    render :home, locals: { posts: current_user.posts }
  end
end
