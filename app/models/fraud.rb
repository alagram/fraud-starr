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
      elsif field.required? && field.name.include?("Twitter")
        errors.add field.name, "is not valid" unless properties[field.name] =~ /@([a-z0-9_]+)/i
      elsif field.required? && field.name.include?("Facebook")
        errors.add field.name, "must be a valid URL" unless properties[field.name] =~ URI::regexp(%w(http https))
      elsif field.required? && field.name.include?("Phone")
        errors.add field.name, "must be a valid Phone number" unless properties[field.name] =~ /^[0-9()-]+$/
      elsif field.required? && field.name.include?("Email")
        errors.add field.name, "must be a valid Email address" unless properties[field.name] =~ /@/
      end
    end
  end
end