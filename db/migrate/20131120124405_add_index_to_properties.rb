class AddIndexToProperties < ActiveRecord::Migration
  def up
    execute "CREATE INDEX frauds_properties_idx ON frauds USING GIN(properties)"
  end

  def down
    execute "DROP INDEX frauds_properties_idx"
  end
end
