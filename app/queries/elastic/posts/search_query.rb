module Elastic
  module Posts
    class SearchQuery
      DEFAULT_RECORDS_COUNT = 100

      def initialize(search_criteria, fuzzy: true)
        @search_criteria = search_criteria
        @fuzzy = fuzzy
      end

      def call
        return Post.first(DEFAULT_RECORDS_COUNT) unless search_criteria.present?

        Post.__elasticsearch__.search(search_object).records
      end

      private

      attr_reader :search_criteria, :fuzzy

      def search_object
        object = {
          query: {
            multi_match: {
              query: search_criteria,
              fields: %w[title body^5 topic]
            }
          }
        }

        object[:query][:multi_match][:fuzziness] = 'AUTO' if fuzzy

        object
      end
    end
  end
end
