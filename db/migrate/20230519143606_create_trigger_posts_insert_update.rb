class CreateTriggerPostsInsertUpdate < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON posts FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        fulltext_tsv, 'pg_catalog.english', body, title, topic
      );
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON posts
    SQL
  end
end
