class User < OmniAuth::Identity::Models::ActiveRecord
  validates_presence_of :email
  validates_presence_of :full_name
  validates_uniqueness_of :email

  def self.create_with_omniauth(auth)
    create! do |user|
      user.full_name = auth["info"]["name"]
      # user.password = rand(36**10).to_s(36)
    end
  end

  has_secure_password validations: false

  has_many :authentications
end