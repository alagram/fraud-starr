class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates_presence_of :password
  validates_presence_of :full_name
  validates_uniqueness_of :email
  validates_format_of :email, with: /@/
end