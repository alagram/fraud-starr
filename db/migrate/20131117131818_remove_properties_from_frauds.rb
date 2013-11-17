class RemovePropertiesFromFrauds < ActiveRecord::Migration
  def change
    remove_column :frauds, :properties
  end
end
