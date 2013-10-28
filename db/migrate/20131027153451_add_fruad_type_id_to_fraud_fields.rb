class AddFruadTypeIdToFraudFields < ActiveRecord::Migration
  def change
    add_column :fraud_fields, :fraud_type_id, :integer
  end
end
