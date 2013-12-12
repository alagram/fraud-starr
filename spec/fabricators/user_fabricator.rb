Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  password_digest { BCrypt::Password.create(SecureRandom.urlsafe_base64).to_s }
end