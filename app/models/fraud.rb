class Fraud < ActiveRecord::Base
  belongs_to :fraud_type
  serialize :properties, Hash
  has_many :images
  accepts_nested_attributes_for :images

  validates_presence_of :title, :fraud_date, :description
  validate :validate_properties

  def validate_properties
    fraud_type.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end
end