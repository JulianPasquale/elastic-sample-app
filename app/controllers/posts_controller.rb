class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Posts::CreateService.new(create_params).call
  end

  private
  
  def create_params
    params.require(:post).permit(:title, :body, :topic)
  end
end
