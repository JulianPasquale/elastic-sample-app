module Posts
  class CreateService
    def initialize(post_params)
      @params = post_params
    end

    def call
      post = Post.create!(params)
      ElasticIndexerJob.perform_later(:create, post)
    end

    private

    attr_reader :params
  end
end
