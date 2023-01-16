module Fulltext
  module Posts
    class DeleteService
      def initialize(post_id)
        @post = Post.find(post_id)
      end

      def call
        post.destroy!
      end

      private

      attr_reader :post
    end
  end
end
  