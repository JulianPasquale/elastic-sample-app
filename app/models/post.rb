class Post < ApplicationRecord
  include Elasticsearch::Model
  include PgSearch::Model

  validates :title, :body, :topic, presence: true

  # Full-text search
  pg_search_scope(
    :search_full_text,
    against: [:body, :title, :topic],
    using: {
      tsearch: {
        dictionary: 'english',
        any_word: true,
        prefix: true,
        tsvector_column: 'fulltext_tsv'
      }
    }
  )

  pg_search_scope(
    :non_cached_full_text_search,
    against: [:body, :title, :topic],
    using: {
      tsearch: {
        dictionary: 'english',
        any_word: true,
        prefix: true
      }
    }
  )

  pg_search_scope(
    :combined_search,
    against: [:body, :title, :topic],
    using: {
      tsearch: {
        dictionary: 'english',
        tsvector_column: 'fulltext_tsv'
      },
      trigram: {
        threshold: 0.3
      }
    }
  )

  pg_search_scope(
    :trigrams_search,
    against: [:body, :title, :topic],
    using: {
      trigram: {
        threshold: 0.3
      }
    }
  )
  
  # ElastichSearch
  alias_method :to_hash, :attributes

  settings number_of_shards: 1 do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english
      indexes :body, type: :text, analyzer: :english
      indexes :topic, type: :keyword
    end
  end
end
