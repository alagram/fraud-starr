module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def fraud_type_options
    options_from_collection_for_select(FraudType.all, :id, :name)
  end

  def options_for_status(selected=nil)
    options_for_select([["Pending", "1"], ["Go Live", "2"], ["Verified", "3"]], selected)
  end
end
