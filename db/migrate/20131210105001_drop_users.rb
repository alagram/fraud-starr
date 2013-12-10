class DropUsers < ActiveRecord::Migration
  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :name

      t.timestamps
    end
  end
end
