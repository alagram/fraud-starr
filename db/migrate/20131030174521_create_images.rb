class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.integer :fraud_id

      t.timestamps
    end
  end

  def down
    drop_table :images
  end
end
