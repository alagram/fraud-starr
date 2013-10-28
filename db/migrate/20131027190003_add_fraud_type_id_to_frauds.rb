class AddFraudTypeIdToFrauds < ActiveRecord::Migration
  def change
    add_column :frauds, :fraud_type_id, :integer
    add_column :frauds, :properties, :text
  end
end
