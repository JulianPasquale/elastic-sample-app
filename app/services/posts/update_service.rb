module Posts
  class UpdateService
    def initialize(post, post_params)
      @params = post_params
      @post = post
    end

    def call
      post.update!(params)
      ::PostRepository.instance.save(post)

      post
    end

    private

    attr_reader :params, :post
  end
end
