class AddIndexToFraudSearch < ActiveRecord::Migration
  def up
    execute "CREATE INDEX fraud_search_idx ON frauds USING GIN(to_tsvector('english', fraud_search))"
  end

  def down
    execute "DROP INDEX fraud_search_idx"
  end
end
