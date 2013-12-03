class User < ActiveRecord::Base
  validates_presence_of :full_name, :email
  validates_uniqueness_of :email
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_secure_password validations: false

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.full_name = auth["info"]["nickname"]
    end
  end
end