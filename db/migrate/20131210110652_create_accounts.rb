class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.integer :user_id
      t.string :oauth_token
      t.string :provider
      t.string :uid
      t.string :username
      t.string :oauth_secret

      t.timestamps
    end
  end

  def down
    drop_table :accounts
  end
end
