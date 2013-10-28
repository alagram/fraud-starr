class CreateFraudTypes < ActiveRecord::Migration
  def change
    create_table :fraud_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :fraud_types
  end
end
