class AddCreatedAtAndUpdateAtToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :create_at, :datetime
    add_column :identities, :updated_at, :datetime
  end
end
