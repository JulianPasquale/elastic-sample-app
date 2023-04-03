module Fulltext
  module Posts
    class SearchQuery
      DEFAULT_RECORDS_COUNT = 100

      def initialize(search_criteria, search_method = :combined_search)
        @search_criteria = search_criteria
        @search_method = search_method
      end

      def call
        return Post.first(DEFAULT_RECORDS_COUNT) unless search_criteria.present?

        Post.send(search_method, search_criteria)
      end

      private

      attr_reader :search_criteria, :search_method
    end
  end
end
