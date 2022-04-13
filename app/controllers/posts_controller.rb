class PostsController < ApplicationController
  def index
    @posts = 
      if params[:search].present?
        Posts::SearchService.new(params[:search]).call
      else
        Post.all
      end
  end

  def show
    @post = find_post
  end

  def new
    @post = Post.new
  end

  def create
    Posts::CreateService.new(post_params).call

    redirect_to posts_path
  end

  def edit
    @post = find_post
  end

  def update
    post = Posts::UpdateService.new(find_post, post_params).call

    redirect_to post
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body, :topic)
  end

  def find_post
    Post.find(params[:id])
  end
end
