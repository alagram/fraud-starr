class RemoveFullNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :full_name, :string
    remove_column :users, :email, :string
    remove_column :users, :password_digest, :string
  end
end
