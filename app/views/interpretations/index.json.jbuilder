json.array!(@interpretations) do |interpretation|
  json.extract! interpretation, :id, :scale_id, :value_from, :value_to, :text
  json.url interpretation_url(interpretation, format: :json)
end
