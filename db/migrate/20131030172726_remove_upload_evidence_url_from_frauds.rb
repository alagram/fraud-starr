class RemoveUploadEvidenceUrlFromFrauds < ActiveRecord::Migration
  def change
    remove_column :frauds, :upload_evidence_url, :string
  end
end
