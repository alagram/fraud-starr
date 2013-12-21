class GenerateTokensForExistingRegularUsers < ActiveRecord::Migration
  def change
    RegularUser.all.each do |user|
      user.update_column(:token, SecureRandom.urlsafe_base64)
    end
  end
end
