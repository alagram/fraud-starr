class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
    end
  end
end
