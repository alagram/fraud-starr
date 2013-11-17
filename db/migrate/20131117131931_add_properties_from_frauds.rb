class AddPropertiesFromFrauds < ActiveRecord::Migration
  def change
    add_column :frauds, :properties, :hstore
  end
end
