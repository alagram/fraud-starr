class AddOAuthExpiresToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :oauth_expires, :string
  end
end
