class Post < ApplicationRecord
  validates :title, :body, :topic, presence: true

  alias_method :to_hash, :attributes
end
