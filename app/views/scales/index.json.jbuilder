json.array!(@scales) do |scale|
  json.extract! scale, :id, :test_id, :name, :questions, :result, :for_user
  json.url scale_url(scale, format: :json)
end
