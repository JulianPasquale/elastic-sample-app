module Fulltext
  module Posts
    class SearchQuery
      DEFAULT_RECORDS_COUNT = 100

      def initialize(search_criteria)
        @search_criteria = search_criteria
      end

      def call
        return Post.first(DEFAULT_RECORDS_COUNT) unless search_criteria.present?

        Post.search_full_text(search_criteria)
      end

      private

      attr_reader :search_criteria
    end
  end
end
