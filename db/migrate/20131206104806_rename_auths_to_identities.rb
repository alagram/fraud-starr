class RenameAuthsToIdentities < ActiveRecord::Migration
  def self.up
    rename_table :auths, :identities
  end

  def self.down
    rename_table :identities, :auths
  end
end
