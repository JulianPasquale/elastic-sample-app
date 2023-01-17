module Elastic
  class PostsController < ApplicationController
    def index
      @facade = Elastic::Posts::IndexFacade.new(params)
    end
  end
end
