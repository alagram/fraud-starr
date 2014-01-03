Fabricator(:fraud_type) do
  name 'Twitter'
  fields_attributes { [Fabricate.attributes_for(:fraud_field)] }
end