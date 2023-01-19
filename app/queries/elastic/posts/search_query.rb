module Elastic
  module Posts
    class SearchQuery
      DEFAULT_RECORDS_COUNT = 100

      def initialize(search_criteria)
        @search_criteria = search_criteria
      end

      def call
        return Post.first(DEFAULT_RECORDS_COUNT) unless search_criteria.present?

        res = Post.__elasticsearch__.search(
          query: {
            multi_match: {
              query: search_criteria,
              fuzziness: 'AUTO',
              fields: %w[title body^5 topic]
            }
          }
        ).records
      end

      private

      attr_reader :search_criteria
    end
  end
end
