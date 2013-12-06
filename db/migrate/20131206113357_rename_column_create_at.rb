class RenameColumnCreateAt < ActiveRecord::Migration
  def change
    rename_column :identities, :create_at, :created_at
  end
end
