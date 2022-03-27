class Post < ApplicationRecord
  include Elasticsearch::Model

  validates :title, :body, :topic, presence: true

  alias_method :to_hash, :attributes

  settings number_of_shards: 1 do
    mappings dynamic: false do
      indexes :id, index: :not_analyzed
      indexes :title, type: :text, analyzer: :english
      indexes :body, type: :text, analyzer: :english
      indexes :topic, type: :keyword
    end
  end
end
