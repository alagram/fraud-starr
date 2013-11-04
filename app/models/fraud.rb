class Fraud < ActiveRecord::Base
  belongs_to :fraud_type
  serialize :properties, Hash
  has_many :images
  accepts_nested_attributes_for :images

  validates_presence_of :title, :fraud_date, :description
  validate :validate_properties
  validate :fraud_date_cannot_be_in_the_future

  def fraud_date_cannot_be_in_the_future
    if fraud_date.present? && fraud_date > Date.today
      errors.add(:fraud_date, 'cannot be in the future')
    end
  end

  def validate_properties
    fraud_type.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end
end