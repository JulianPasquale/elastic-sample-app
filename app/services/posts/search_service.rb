module Posts
  class SearchService
    def initialize(search_criteria)
      @search_criteria = search_criteria
    end

    def call
      return Post.all unless search_criteria.present?

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
