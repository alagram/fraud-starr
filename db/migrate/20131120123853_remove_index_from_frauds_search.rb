class RemoveIndexFromFraudsSearch < ActiveRecord::Migration
  def up
    execute "DROP INDEX fraud_search_idx"
  end

  def down
    execute "CREATE INDEX fraud_search_idx ON frauds USING GIN(to_tsvector('english', fraud_search))"
  end
end
