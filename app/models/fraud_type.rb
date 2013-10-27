class FraudType < ActiveRecord::Base
  has_many :fields, class_name: "FraudField"
  accepts_nested_attributes_for :fields, allow_destroy: true
  validates_presence_of :name
end