json.array!(@users) do |user|
  json.extract! user, :id, :name, :sex, :age, :work, :profession, :workFunction, :workAge
  json.url user_url(user, format: :json)
end
