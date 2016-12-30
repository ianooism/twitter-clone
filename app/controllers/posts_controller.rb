class PostsController < ApplicationController
  def index
    render :index, locals: { posts: current_user.explore_posts }
  end
  
  def show
    render :show, locals: { post: requested_post }
  end
  
  def new
    render :new, locals: { post: new_post }
  end
  
  def create
    if new_post.update(post_form_params)
      redirect_to posts_url, notice: "Post created."
    else
      render :new, locals: { post: new_post }
    end
  end
  
  def edit
    render :edit, locals: { post: requested_post }
  end
  
  def update
    if requested_post.update(post_form_params)
      redirect_to posts_url, notice: "Post updated."
    else
      render :edit, locals: { post: requested_post }
    end
  end
  
  def destroy
    requested_post.destroy
    redirect_to posts_url, notice: "Post destroyed."
  end
  
  private
    def requested_post
      @post ||= Post.find(params[:id])
    end
    
    def new_post
      @post ||= Post.new(new_post_params)
    end
    
    def new_post_params
      { owner: current_user }
    end
    
    def post_form_params
      params.require(:post).permit(:body)
    end
end
