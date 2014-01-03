class User < ActiveRecord::Base
  has_many :accounts, dependent: :destroy
  has_many :frauds
end