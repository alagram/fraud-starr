class Fraud < ActiveRecord::Base
  include Tokenable
  belongs_to :fraud_type
  has_many :images
  accepts_nested_attributes_for :images, :reject_if => proc { |attr| attr['image'].blank? }
  belongs_to :user

  before_validation :append_at_sign_to_twitter_handle
  validates_presence_of :title, :fraud_date, :description
  validate :validate_properties
  validate :fraud_date_cannot_be_in_the_future
  validate :must_have_evidence


  def self.search(query)
    conditons = <<-EOS
      to_tsvector('english', CAST(avals(properties) AS text)) @@ plainto_tsquery('english', #{sanitize(query)})
    EOS

    where(conditons, query).order("created_at DESC")
  end

  def fraud_date_cannot_be_in_the_future
    if fraud_date.present? && fraud_date > Date.today
      errors.add(:fraud_date, 'cannot be in the future')
    end
  end

  def validate_properties
    fraud_type.fields.each do |field|
      perform_validation!(field)
    end
  end

  def display_text
    description.split.size > 4 ? short_desc : description
  end

  def show_status
    if status == "1"
      "Pending"
    elsif status == "2"
      "Go Live"
    elsif status == "3"
      "Verified"
    end
  end

  def to_param
    token
  end


  private

  def short_desc
    description.split.first(4).join(" ").concat(", more...")
  end

  def append_at_sign_to_twitter_handle
    if properties["Twitter Handle"].present? && properties["Twitter Handle"].start_with?("@")
      self.properties["Twitter Handle"]
    else
      self.properties["Twitter Handle"][0,0] = "@" if properties["Twitter Handle"].present?
    end
  end

  def perform_validation!(field)
    if field.required? && properties[field.name].blank?
      errors.add field.name, "must not be blank"
    elsif field.required? && field.name.include?("Twitter")
      errors.add field.name, "is not valid" unless properties[field.name] =~ /@([a-z0-9_]+)/i
    elsif field.required? && field.name.include?("Facebook")
      errors.add field.name, "must be a valid Facebook URL" unless properties[field.name] =~ /^(https?:\/\/)?((w{3}\.)?)facebook.com\/.*/i
    elsif field.required? && field.name.include?("Phone")
      errors.add field.name, "must be a valid Phone number" unless properties[field.name] =~ /^\d{10}$/
    elsif field.required? && field.name.include?("Email")
      errors.add field.name, "must be a valid Email address" unless properties[field.name] =~ /@/
    end
  end

  def must_have_evidence
    errors[:base] << "Please upload evidence" if images_empty?
  end

  def images_empty?
    images.empty?
  end
end