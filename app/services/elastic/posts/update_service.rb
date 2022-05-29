module Elastic
  module Posts
    class UpdateService
      def initialize(post_id, post_params)
        @post = Post.find(post_id)
        @params = post_params
      end

      def call
        post.update!(params)
        ElasticIndexerJob.perform_later(:update, post)

        post
      end

      private

      attr_reader :params, :post
    end
  end
end
