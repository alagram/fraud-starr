class RegularUser < User

  has_secure_password validations: false

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end