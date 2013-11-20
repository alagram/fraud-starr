class AddFraudSearchToFrauds < ActiveRecord::Migration
  def change
    add_column :frauds, :fraud_search, :string
  end
end
