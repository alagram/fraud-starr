Fabricator(:fraud) do
  title { Faker::Lorem.words(2).join }
  description { Faker::Lorem.paragraph(3) }
  fraud_date Time.now.strftime("%Y-%m-%d")
  fraud_type
end