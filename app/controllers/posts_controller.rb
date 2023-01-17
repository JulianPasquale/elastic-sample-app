class PostsController < ApplicationController

  def index; end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Posts::CreateService.new(post_params).call

    redirect_to @post
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Posts::UpdateService.new(params[:id], post_params).call

    redirect_to @post
  end

  def destroy
    Posts::DeleteService.new(params[:id]).call

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :topic)
  end
end
