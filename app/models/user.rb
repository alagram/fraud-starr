class User < ActiveRecord::Base
  has_many :accounts, dependent: :destroy
  has_many :frauds

  def full_name
    [first_name, last_name].join(" ")
  end
end
