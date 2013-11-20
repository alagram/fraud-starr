class RemoveFraudSearchFromFrauds < ActiveRecord::Migration
  def change
    remove_column :frauds, :fraud_search
  end
end
