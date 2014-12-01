json.array!(@questions) do |question|
  json.extract! question, :id, :text, :test_id
  json.url question_url(question, format: :json)
end
