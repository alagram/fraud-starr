class DropAuthentications < ActiveRecord::Migration
  def up
    drop_table :authentications
  end

  def down
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
