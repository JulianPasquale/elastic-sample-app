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
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    Posts::CreateService.new(create_params).call

    redirect_to posts_path
  end

  def edit
    @post = Post.new
  end

  def update
  end

  private
  
  def create_params
    params.require(:post).permit(:title, :body, :topic)
  end
end
