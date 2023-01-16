class Post < ApplicationRecord
  include Elasticsearch::Model
  include PgSearch::Model

  validates :title, :body, :topic, presence: true

  # Full-text search
  # multisearchable against: [:title, :body, :topic]
  pg_search_scope(
    :search_full_text,
    against: [:title, :body, :topic],
    using: [:tsearch]
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
