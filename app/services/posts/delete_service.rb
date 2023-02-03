module Posts
  class DeleteService
    def initialize(post_id)
      @post = Post.find(post_id)
    end

    def call
      ElasticIndexerJob.perform_later(:delete, post)
      post.destroy!
    end

    private

    attr_reader :post
  end
end
  