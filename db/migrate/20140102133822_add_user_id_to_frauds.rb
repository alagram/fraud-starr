class AddUserIdToFrauds < ActiveRecord::Migration
  def change
    add_column :frauds, :user_id, :integer
  end
end
