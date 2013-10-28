class CreateFrauds < ActiveRecord::Migration
  def change
    create_table :frauds do |t|
      t.string :title
      t.text :description
      t.date :fraud_date
      t.string :upload_evidence_url

      t.timestamps
    end
  end

  def downn
    drop_table :frauds
  end
end
