Fabricator(:fraud) do
  title { Faker::Lorem.words(2).join }
  description { Faker::Lorem.paragraph(3) }
  fraud_date Time.now.strftime("%Y-%m-%d")
  properties { Hash['Twitter Handle', '@agram'] }
  images_attributes {
    Array(
      ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/uploads/argo.jpg")),
      :filename => File.basename(File.new(Rails.root.join("spec/support/uploads/argo.jpg")))
      )
    )
  }
  fraud_type
end