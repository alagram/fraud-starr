class FraudType < ActiveRecord::Base
  has_many :fields, class_name: "FraudField"
end