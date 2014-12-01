json.array!(@answers) do |answer|
  json.extract! answer, :id, :text, :answer_value, :test_id, :question_id
  json.url answer_url(answer, format: :json)
end
