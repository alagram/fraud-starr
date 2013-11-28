Fabricator(:image) do
  image {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/uploads/argo.jpg")),
      :type => 'image/jpg',
      :filename => File.basename(File.new(Rails.root.join("spec/support/uploads/argo.jpg")))
    )
  }
end