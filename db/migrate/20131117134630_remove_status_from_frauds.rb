class RemoveStatusFromFrauds < ActiveRecord::Migration
  def change
    remove_column :frauds, :status
  end
end
