module Fulltext
  class PostsController < ApplicationController
    def index
      @facade = Fulltext::Posts::IndexFacade.new(params)
    end
  end
end
