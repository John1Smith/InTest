json.array!(@scale_results) do |scale_result|
  json.extract! scale_result, :id, :scale_id, :user_id, :result
  json.url scale_result_url(scale_result, format: :json)
end
