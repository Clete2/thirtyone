json.array!(@people) do |person|
  json.extract! person, :id, :firstname, :lastname, :phone, :phone_ext
  json.url person_url(person, format: :json)
end
