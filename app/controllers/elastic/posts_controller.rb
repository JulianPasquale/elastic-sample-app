module Elastic
  class PostsController < ApplicationController
    def index
      @form = SearchForm.new(search_params)
      @posts = Posts::SearchQuery.new(@form.search).call
    end

    def show
      @post = Post.find(params[:id])
    end

    def new
      @post = Post.new
    end

    def create
      @post = Posts::CreateService.new(post_params).call

      redirect_to [:elastic, @post]
    end

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Posts::UpdateService.new(params[:id], post_params).call

      redirect_to [:elastic, @post]
    end

    def destroy
      @post = Post.find(params[:id])

      @post.destroy!

      redirect_to elastic_posts_path
    end

    private
    
    def search_params
      params.require(:elastic_search_form).permit(:search) if params[:elastic_search_form]
    end

    def post_params
      params.require(:post).permit(:title, :body, :topic)
    end
  end
end
