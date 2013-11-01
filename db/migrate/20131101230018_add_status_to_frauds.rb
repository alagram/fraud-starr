class AddStatusToFrauds < ActiveRecord::Migration
  def change
    add_column :frauds, :status, :string, default: 1
  end
end
