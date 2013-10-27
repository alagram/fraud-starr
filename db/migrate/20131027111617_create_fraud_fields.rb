class CreateFraudFields < ActiveRecord::Migration
  def change
    create_table :fraud_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required

      t.timestamps
    end
  end
end
