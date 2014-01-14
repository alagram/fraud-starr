class AddTokenToFrauds < ActiveRecord::Migration
  def change
    add_column :frauds, :token, :string
  end
end
