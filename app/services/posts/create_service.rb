module Posts
  class CreateService
    def initialize(post_params)
      @params = post_params
    end

    def call
      post = Post.create!(params)
      ::PostRepository.instance.save(post)
    end

    private

    attr_reader :params
  end
end
