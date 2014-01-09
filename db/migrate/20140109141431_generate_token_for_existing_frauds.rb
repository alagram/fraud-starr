class GenerateTokenForExistingFrauds < ActiveRecord::Migration
  def change
    Fraud.all.each do |fraud|
      fraud.update_column(:token, SecureRandom.urlsafe_base64)
    end
  end
end
