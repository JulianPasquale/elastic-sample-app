module Posts
  class SearchService
    def initialize(criteria)
      @criteria = criteria
    end

    def call
      PostRepository.default_instance.search(
        query: {
          multi_match: {
            query: criteria,
            fuzziness: 'AUTO',
            fields: %w[title body^5]
          }
        }
      )
    end

    private

    attr_reader :criteria
  end
end
