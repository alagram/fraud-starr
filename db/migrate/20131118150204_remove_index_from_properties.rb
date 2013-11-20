class RemoveIndexFromProperties < ActiveRecord::Migration
  def up
    execute "DROP INDEX frauds_properties"
  end

  def down
    execute "CREATE INDEX frauds_properties ON frauds USING GIN(properties)"
  end
end
