module Elastic
  module Posts
    class IndexFacade
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def filter_form
        @filter_form ||= SearchForm.new(search_params)
      end
      
      def posts
        @posts ||= Posts::SearchQuery.new(filter_form.search).call
      end

      private

      def search_params
        params.require(:elastic_search_form).permit(:search) if params[:elastic_search_form]
      end
    end
  end
end
