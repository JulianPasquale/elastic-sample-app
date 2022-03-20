module Posts
  class CreateService
    def initialize(post_params)
      @params = post_params
    end

    def call
      Post.transaction do
        post = Post.create!(params)
        PostRepository.default_instance.save(post)
      end
    end

    private

    attr_reader :params
  end
end
