Fabricator(:regular_user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  password '123abc'
  admin false
end

Fabricator(:admin, from: :regular_user) do
  admin true
end