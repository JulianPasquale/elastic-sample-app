class AddTsvectorColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :fulltext_tsv, :tsvector
    add_index :posts, :fulltext_tsv, using: "gin"
  end
end
