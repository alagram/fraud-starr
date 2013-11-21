class User < ActiveRecord::Base
  validates_presence_of :full_name, :email
  validates_uniqueness_of :email
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_secure_password validations: false
end