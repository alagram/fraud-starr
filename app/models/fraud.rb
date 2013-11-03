class Fraud < ActiveRecord::Base
  belongs_to :fraud_type
  serialize :properties, Hash
  has_many :images
  accepts_nested_attributes_for :images

  validates_presence_of :title, :fraud_date, :description
  validate :validate_properties
  validate :check_fraud_date

  before_save :save_fraud_date

  attr_writer :fraud_date

  def fraud_date
    @fraud_date || fraud_date.try(:strftime, "%Y-%m-%d")
  end

  def save_fraud_date
    self.fraud_date = Time.zone.parse(@fraud_date) if @fraud_date.present?
  end

  def check_fraud_date
    if @fraud_date.present? && Time.zone.parse(fraud_date).nil?
      errors.add :fraud_date, "cannot be parsed"
    end
  rescue ArgumentError
    errors.add :fraud_date, "is out of range"
  end

  def validate_properties
    fraud_type.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end
end